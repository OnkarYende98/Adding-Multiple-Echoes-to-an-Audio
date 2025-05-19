% Load the audio file
[audio, Fs] = audioread("Enter the audio file"); % Replace with your audio file


sound(audio, Fs);

% Parameters for multiple echoes
num_echoes = 5;             % Number of echoes to add
delay_in_seconds = 1;       % Delay for each echo in seconds
attenuation_factor = 0.5;   % Attenuation factor for the first echo

% Convert delay from seconds to samples
delay_in_samples = round(delay_in_seconds * Fs);

% Create a signal for audio with multiple echoes
audio_with_echoes = audio;  % Initialize the signal with the original audio

% Loop to add each echo
for echo_num = 1:num_echoes
    % Current attenuation level
    current_attenuation = attenuation_factor;
    
    % Add the delayed and attenuated signal
    for i = (echo_num * delay_in_samples + 1):length(audio) %total no. of samples
        audio_with_echoes(i) = audio_with_echoes(i) + current_attenuation * audio(i- delay_in_samples * echo_num);
    end
end

%% Plot the original audio signal
figure;
subplot(2,1,1);  
plot(audio);  
title('Original Audio Signal');
xlabel('Time (seconds)');
ylabel('Amplitude');

% Plot the audio signal with echoes
subplot(2,1,2); 
plot(audio_with_echoes);
title('Audio Signal with Echoes');
xlabel('Time (seconds)');
ylabel('Amplitude');

%% FFT 

% Calculate the FFT of the original audio and audio with echoes
N = length(audio);  % Number of samples
f = (0:N-1)*(Fs/N); % Frequency vector

% FFT of the original audio
fft_audio = fft(audio);
magnitude_audio = abs(fft_audio);  % Magnitude spectrum
phase_audio = angle(fft_audio);    % Phase response

% FFT of the audio with echoes
fft_audio_with_echoes = fft(audio_with_echoes);
magnitude_audio_with_echoes = abs(fft_audio_with_echoes);  % Magnitude spectrum
phase_audio_with_echoes = angle(fft_audio_with_echoes);    % Phase response

%% Magnitude Spectrum

% Plot the magnitude spectrum of the original and echoed audio
figure;
subplot(2,1,1);
plot(f, magnitude_audio);
title('Magnitude Spectrum of Original Audio');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

subplot(2,1,2);
plot(f, magnitude_audio_with_echoes);
title('Magnitude Spectrum of Audio with Echoes');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

%% Phase Response


% Plot the phase response of the original and echoed audio
figure;
subplot(2,1,1);
plot(f, phase_audio);
title('Phase Response of Original Audio');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');

subplot(2,1,2);
plot(f, phase_audio_with_echoes);
title('Phase Response of Audio with Echoes');
xlabel('Frequency (Hz)');
ylabel('Phase (radians)');
    

% Play the audio with multiple echoes
sound(audio_with_echoes, Fs);

% Save the result to a new file
audiowrite('audio_with_multiple_echoes.wav', audio_with_echoes, Fs);
