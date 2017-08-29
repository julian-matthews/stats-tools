%% 2017-08-09 Julian - Type-2 D' calculator
% Expects -4 to 4 confidence judgments
% Estimate of metacognitive sensitivity
%
% Input signal correctness ('correct') = [0 1] or Left & Right
% Input decision confidence ('conf') = absolute [1:4]
%
% Output is a pure frequency table and cumulative frequencies
% Also Type-I AUC calculated using AreaUnderROC

function [t2_dprime,t2_criterion] = type2dprime(correct,conf,confid_threshold)

if nargin==2
    confid_threshold = 3;
end

% Ensure confidence is absolute value
conf = abs(conf);

% Recode into high||low confidence
for this = 1:length(conf)
    if conf(this) >= confid_threshold
        reconf(this) = 1;
    elseif conf(this) <= (confid_threshold-1)
        reconf(this) = -1;
    end
end

Frq = zeros(2);

% Frequencies table
for row = 1:length(correct)
    for confidence = 1 % HIGH CONFIDENCE
        if reconf(row)==confidence && correct(row)==1
            Frq(1,1) = Frq(1,1)+1; % HIT
        elseif reconf(row)==confidence && correct(row)==0
            Frq(2,1) = Frq(2,1)+1; % FALSE ALARM
        end
    end
    for confidence = -1 % LOW CONFIDENCE
        if reconf(row)==confidence && correct(row)==1
            Frq(1,2) = Frq(1,2)+1; % MISS
        elseif reconf(row)==confidence && correct(row)==0
            Frq(2,2) = Frq(2,2)+1; % CORRECT REJECT
        end
    end
end

%% Dprime & CRITERION: ASSUMES -1 IS HIT
% Includes loglinear correction approach from Hautus,1995
% Add 0.5 to hits & FAs, add 1 to Signal-Presence & Signal-Absence

% Hitrate = SUM(H2) / SUM(H2)+SUM(M2)
hitrate = (sum(Frq(1,1))+.5)/(sum(Frq(1,:))+1);

% Falserate = SUM(FA2) / SUM(FA2)+SUM(CR2)
falserate = (sum(Frq(2,1))+.5)/(sum(Frq(2,:))+1);

[t2_dprime,t2_criterion] = dprime_simple(hitrate,falserate);

end

%% INCLUDES dprime_simple for portability

function [dp,c] = dprime_simple(h,fA)
% DPRIME_SIMPLE d' calculation given hit/false alarm rates
%   dp = dprime_simple(h,fA) returns the d' value dp 
%   for the hit rate h and false alarm rate fA
%   Karin Cox 8/31/14
%   updates:
%   8/31/14 added criterion output c, input arg checks   
%
%   inputs: 
%   h = hit rate, as float (0 < h < 1) 
%   fA = false alarm rate, as float (0 < fA < 1)
%
%   outputs: 
%   dp = d'
%   c = criterion c (negative values --> bias towards yes responses)
%
%   Example:
%   [dp,c] = dprime_simple(0.9,0.05)   
%   dp =
%     2.9264
%   c = 
%     0.1817
%
%   formulas: Stanislaw, H., & Todorov, N. (1999). Calculation of signal 
%   detection theory measures. Behavior research methods, instruments, & 
%   computers, 31(1), 137-149.


% check n args
narginchk(2,2);

% check for values out of bounds, also issue errors or warnings if =1 or 0
if or(or(h>1,h<0),or(fA>1,fA<0))
    error('input arguments must fall in the 0 to 1 range')
% standard d' formula returns NaN or Inf results for 0 or 1 inputs,
% corrections may be required (see article above for suggestions)
elseif or(or(h==1,h==0),or(fA==1,fA==0))
    warning('This function will not return finite values when h or fA = 0 or 1.')
end


% d prime = z(h)-z(fA)
dp = norminv(h)-norminv(fA);

% c = -0.5*[z(h)+z(fA)]
c = -0.5*(norminv(h)+ norminv(fA));

end
