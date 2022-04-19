%DSP Final Project

%Question 1

disp('initial commit')
disp('testing')


[v,Fs] = audioread('poggers2.wav');

% Question 2

v = v(:,1);
y = v;
c = 0.98;

for n= 2:length(v)
    y(n) = v(n) - c*v(n-1);
end

%Prove that the above pre-emphasis step emphasizes high frequencies.
%In this case, we are interested in 



%Question 3

%y1 = abs(fft(xcorr(y,30)));
y1 = abs(fft(xcorr(y,y)));
figure(1)
stem(y1);
title('DFt of auto correlation of y(n)');
xlabel("omega")
ylabel("|H(w)|")

%Question 4

y2 = abs(fft(y)).^2;
figure(2)
stem(y2);
title('DFT of the magnitude squared of y(n)');
xlabel("omega")
ylabel("|H(w)|")

%Question 5  , stuff we are not so sure of


%sound(v,Fs);
[a,g] = lpc(y,30); %getting 30 AR coefficients for the funciton

%[a,g] = lpc(v,30); Might try using V for better results

% Question6

ar = filter(1,a,y); % y(n) = voice*ARfilter
%ar = filter(a,1,v); % y(n) = voice*ARfilter, maybe look at v

ARw = fft(ar, length(v));
frequencies = linspace(0,Fs,length(v));
figure(3)
plot(frequencies, abs(ARw),  '--b');
hold on
plot(frequencies, abs(fft(y,length(v))), 'or');
title('Spectrum of y(n) Overlapped with the AR Specturm)');
xlabel("omega")
ylabel("|H(w)|")
legend('AR Spectrum', 'y(n) Spectrum');
hold off

figure(4)

plot(frequencies, abs(ARw),  '--b');
title('AR Spectrum')
figure(5)

plot(frequencies, abs(fft(y,length(v))), 'or');
title('Spectrum of y(n)')
xlabel("omega")
ylabel("|H(w)|")

% Question 7
%formants are equal to the roots of A 
formants = roots(a);


%Question 8
%method 1
% f0 = pitch(y,Fs);
% pitchPeriod = Fs/(mean(f0)); %might be more accurate to choose the most common occurring value

% method 2


[cepstrum,recon] = rceps(y);
figure(7)

semilogy(abs(recon));
title('cepstrum of pre-emphasized voice y(n)')
figure(8)

semilogx(abs(recon));
title('cepstrum semilogx of pre-emphasized voice y(n)')
%method1 get 110,250
%method2 get 111,860
%Noah's voice gets 149,784




%Question 9


%Question 10

%number how many segments do you want to break the signal into x segments
%of equal amount samples

%for each individual segment take an independent AR coefficient set, take the LPC

%Then create an impulse train from 1 spaced equally btwn pitch period
% impulse = 

%take each LPC segment and their a and convolve with the impulse function
% then put them all together
% and play them.
%classnumber, file number

% class 1
v1 = zeros(10,1);
Fs1 = zeros(10,1);
v2 = zeros(10,1);
Fs2 = zeros(10,1);

[v10,Fs10] = audioread('poggers.wav');
for i=1:10
[v1(i),Fs1(i)] = audioread("poggers"+i+"class1.wav");
end

%class2
[v20,Fs20] = audioread('poggers.wav');
for i=1:10
[v2(i),F2(i)] = audioread("poggers"+i+"class2.wav");
end

%applying pre-Emphasis on all signals
for i=1:10
    v1(i) = preEmphasis(v1(i));
    v2(i) = preEmphasis(v2(i));
end
v10 = preEmphasis(v10);
v20 = preEmphasis(v20);
%ar-coefficients calculation
PoleCount = 30;
for i=1:10
    [v1(i),~] = lpc(v1(i),PoleCount);
    [v2(i),~] = lpc(v2(i),PoleCount);
end
[v10,~] = lpc(v10,PoleCount);
[v20,~] = lpc(v20,PoleCount);
class1 = zeros(11, PoleCount+1);
class2 = zeros(11, PoleCount+1);
for i=1:10
    class1(i,:) = v1(i);
   class2(i,:) = v2(i);
end
[v10,Fs10] = audioread('poggers.wav');
for i=1:10
hi = strcat('poggers',num2str(i),'class1.wav');
[v1{i},Fs1{i}] = audioread(hi);
end
%class2
[v20,Fs20] = audioread('poggers2.wav');
for i=1:10
hi = strcat('poggers',num2str(i),'class2.wav');
[v2{i},Fs2{i}] = audioread(hi);
end
%applying pre-Emphasis on all signals
for i=1:10
    v1{i} = preEmphasis(v1{i});
    v2{i} = preEmphasis(v2{i});
end
v10 = preEmphasis(v10);
v20 = preEmphasis(v20);
%ar-coefficients calculation
PoleCount = 30;
for i=1:10
    [v1{i},~] = lpc(v1{i},PoleCount);
    [v2{i},~] = lpc(v2{i},PoleCount);
end
[v10,~] = lpc(v10,PoleCount);
[v20,~] = lpc(v20,PoleCount);
class1 = zeros(11, PoleCount+1);
class2 = zeros(11, PoleCount+1);
for i=1:10
    class1(i,:) = v1{i};
   class2(i,:) = v2{i};
end
class1(11,:) = v10;
class2(11,:) = v20;
interclass = zeros(22, PoleCount+1);
for i=1:10
    interclass(i,:) = v1{i};
    interclass(11+i,:) = v2{i};
end
interclass(11,:) = v10;
interclass(22,:) = v20;
%average euclidean distance calculation  calculation
intraClass1 = eucDistance(class1)
intraClass2 = eucDistance(class2)
interClassDistance = eucDistance(interclass)

