
clear all
fps=30;
list_trials=dir('4*');
x=zeros([length(list_trials),1],'single');
f=waitbar(0,'loading synchronizing vector');
%TiffStack(550,800,length(list_trials))=zeros;
for index_trial=1:length(list_trials)
    waitbar(index_trial/length(list_trials))
            image=imread(list_trials(index_trial).name);
            x(index_trial,1)=mean(image(:));  
            
            %index_trial
end
close(f)

%%
maxX=round(max(x));
maxVect=(maxX-(maxX/10):maxX);
xR=round(x);
locations=find(xR>maxX-(maxX/100));

%%

i=0;


for index=1:length(locations)
    try
    check=(x(locations(index)))/(x((locations(index))+1));
    

    if check>1.25
        i=i+1;
        position_end(i)=locations(index);
    end
    end
end
%%
spacing=round((position_end(1,10)-position_end(1,9))/fps);

    if spacing==10
        chunk=fps*spacing-fps;
        disp('flash')
    elseif spacing==15
        chunk=fps*spacing-fps;
        
        disp('bar')
    elseif spacing==30
        chunk=fps*spacing-fps;
        disp('moving object')
    end

position_end(:,1)=[];%%this is due to the mixed order in frames in the first trial. Cant getspinview to lead with zeroes.


    position_end(:,end)=[]; %in order to avoid running out of matrix
%%
meanChunk=chunk/(fps/10);
[sizex,sizey]=size(image);

%mmovproc=zeros([sizex,sizey,meanChunk]);
%temp=zeros([sizex,sizey,meanChunk,length(position_end)]);
%preMean=zeros([550,800,chunk,length(position_end)],'single');
%%
% figure
% hold on

FourD_out=zeros([sizex,sizey,meanChunk,length(position_end)]);
%%
BigTemp=zeros(sizex,sizey,meanChunk);
f=waitbar(0,'total');
for index2=1:(length(position_end))
    waitbar(index2/length(position_end))
    clear temp
    g=waitbar(0,'current iteration');

    bins=(1:chunk/meanChunk:chunk);
    count=0;
    for i=1:chunk
        if ismember(i,bins)
        count=count+1;
        waitbar(count/meanChunk)
        tempM=zeros(sizex,sizey);
            for j=0:(chunk/meanChunk)-1
                 temp=double(imread(list_trials((position_end(index2)+(i-1)+j)).name));
                 tempM=tempM+temp;
            end 
         BigTemp(:,:,count)=BigTemp(:,:,count)+tempM;
        end
    end
    
    close(g)
end
close(f)
    %%%%%%meanpix
mmovproc = BigTemp-mean(BigTemp,3);
close(f)

 %%
[output_mov,output_map]=plotter(mmovproc,5)
 
%% 
function [output_mov,output_map]=plotter(mmovproc,sigma)
close all 
gauss=imgaussfilt3(mmovproc,sigma);
gauss=detrend(gauss);
output_mov=figure, imshow3D(gauss)

output_map=figure

[fig_phase]=retinotopy(gauss)
title('gaussian filtering')
% subplot(2,1,2)
% [fig_phase]=retinotopy(mov)
% title('moving mean')

% subplot(2,1,2)
% imshow(vasc(:,:,1))
end
 
function [fig_phase]=retinotopy(array)
[sizex,sizey,sizeZ]=size(array);
data=reshape(array,[sizex*sizey],(sizeZ));
data=permute(data,[2,1]);
Fs = 10; L = size(data,1);
f = Fs*(0:(L/2))/L; %frequency vector
ftarget = 0.07;
D = fft(data);%calculate full fft
pow = abs(D.^2);
[~,ind] = min(abs(f-ftarget));
pow = pow(ind,:);
phase = angle(D(ind,:)) + pi;
%figure, imagesc(log(reshape(pow, [sizex,sizey])))
%phase
fig_phase=imagesc(reshape(phase./(2*pi), [sizex,sizey])); colormap jet
end