function marius_pschtlbx(nFrames,stimul)
close all
PsychDefaultSetup(2);
%Screen('Preference', 'SkipSyncTests', 1);
screenNumber = 2;

white = WhiteIndex(screenNumber);
if nargin==0
    stimul='down'
    nFrames=600;
    disp('default, bottom up, 600frames')
end
%a=arduino;
grey = 0.5;
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
[width, height]=Screen('WindowSize', screenNumber);
% width=1280;
% height=720;
w=width;
h=height;

switch stimul
    case {'up','down'}
        [bigBoardX,~]=movingboard(nFrames,h,w);
        toggle='X';
    case {'left','right'}
        [~,bigBoardY]=movingboard(nFrames,h,w);
        toggle='Y';
end

% 
%  


%% session trigger via bpod

% 
%  sma = prepareStateMachine;
%  TrialManager = TrialManagerObject;
%  TrialManager.startTrial(sma);

%% session trigger via arduino
% writeDigitalPin(a, 'D11', 0);
% %pause(2);
% writeDigitalPin(a, 'D11', 1);

%%
switch toggle
    case 'X'
        for total=1:50  
        total
        for index=1:10
            [imageTexture]=Texture_generator(stimul,bigBoardX,window)
            for frame=1:600
            Screen('DrawTexture', window, imageTexture(frame), [], [] ,0, [], []);
            Screen('Flip', window);
            end
        end
        end
    case'Y'
        for total=1:50  
        total
            for index=1:10
                [imageTexture]=Texture_generator(stimul,bigBoardY,window);
                for frame=1:600
                Screen('DrawTexture', window, imageTexture(frame), [], [] ,0, [], []);
                Screen('Flip', window);
                end
            end
        end
end

end    
    
    
    
    
    
    
    
    
    
    
    
    
    
    %     index
%     writeDigitalPin(a, 'D11', 1);
%     pause(0.1)
%     writeDigitalPin(a, 'D11', 0);
%     pause(0.9)
%     for n=1:600
%         Screen('Close');
%         switch stimul
%             case 'up'
%         imageTexture = Screen('MakeTexture', window, bigBoardX(:,:,n));
%             case 'down'
%         imageTexture = Screen('MakeTexture', window, bigBoardX(:,:,abs(n-601)));
%             case 'left'
%         imageTexture = Screen('MakeTexture', window, bigBoardY(:,:,n));
%             case 'right'
%         imageTexture = Screen('MakeTexture', window, bigBoardY(:,:,abs(n-601)));
%        
%         end
%         
%         Screen('DrawTexture', window, imageTexture, [], [] ,0, [], []);
%         Screen('Flip', window);
%         
%     end
%     %pause(4)
%end

%     writeDigitalPin(a, 'D11', 0);
%     writeDigitalPin(a, 'D11', 1);
% 
% 
% for index=1:10
%     for n=1:600
%         Screen('Close');
%         imageTexture = Screen('MakeTexture', window, bigBoardX(:,:,abs(n-601)));
%         Screen('DrawTexture', window, imageTexture, [], [] ,0, [], []);
%         Screen('Flip', window);
%     end
% end
% 
% 
%     writeDigitalPin(a, 'D11', 0);
%     writeDigitalPin(a, 'D11', 1);
% 
% 
% for index=1:10
% 
%     
%     for n=1:600
%         Screen('Close');
%         imageTexture = Screen('MakeTexture', window, bigBoardY(:,:,n));
%         Screen('DrawTexture', window, imageTexture, [], [] ,0, [], []);
%         Screen('Flip', window);
%     end
% end
% 
%     writeDigitalPin(a, 'D11', 0);
%     writeDigitalPin(a, 'D11', 1);
% 
% 
% for index=1:10
%     for n=1:600
%         Screen('Close');
%         imageTexture = Screen('MakeTexture', window, bigBoardY(:,:,abs(n-601)));
%         c
%     end
% end
%     writeDigitalPin(a, 'D11', 0);
%     pause(5);
%     writeDigitalPin(a, 'D11', 1);
% end
% 
%     writeDigitalPin(a, 'D11', 0);
%     pause(5);
%     writeDigitalPin(a, 'D11', 1);




function [imageTexture]=Texture_generator(stimul,bigBoard,window)

    for n=1:600
            %Screen('Close');
            switch stimul
                case 'up'
            imageTexture(n) = Screen('MakeTexture', window, bigBoard(:,:,n));
                case 'down'
            imageTexture(n) = Screen('MakeTexture', window, bigBoard(:,:,abs(n-601)));
                case 'left'
            imageTexture(n) = Screen('MakeTexture', window, bigBoard(:,:,n));
                case 'right'
            imageTexture(n) = Screen('MakeTexture', window, bigBoard(:,:,abs(n-601)));

            end
    end
end
