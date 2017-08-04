function [ within_subj_error, error_matrix] = within_subject_error( data, fixed )
%
% [ within_subj_error, error_matrix] = within_subject_error( data, fixed )
%
% WITHIN-SUBJECT ERROR BARS for WITHIN-SUBJECT DESIGNS
%   Based off method described by Cousineau (2005): 'Confidence 
%   intervals in within-subject designs' and updated in O'Brien & Cousineau
%   (2014): 'Representing error bars in within-subject designs in typical 
%   software packages'
%   
%   ====INPUT 'data'========
%   Input 'data' matrix such that each row specifies a participant and 
%   each column specifies a condition (i.e. row#2 in column#1 is the same
%   subject as row#2 in column#2)
%   
%   ====INPUT 'fixed'=======
%   At the moment, this code assumes no fixed factors are being analysed
%   and applies a conservative correction factor to compute error if the
%   'fixed' variable is unspecified.
%
%   Fixed factors allow for more lenient correction and, thus, narrower
%   error. Input 'fixed' as a vector such that fixed(1) is the number of
%   fixed factors and fixed(2) are their levels.
%
%   The following link has some information on determining whether your
%   experiment employs fixed or random factors: 
%
%   See: http://www.theanalysisfactor.com/specifying-fixed-and-random-factors-in-mixed-models/
%   
%   ====NOTES==============
%   A similar process for removing between-subject variability is 
%   described by CogSci.nl without the Morey (2008) correction.
%
%   See: http://www.cogsci.nl/blog/tutorials/156-an-easy-way-to-create-graphs-with-within-subject-error-bars
%
%   Julian Matthews (2017)

condition_matrix = data; 
subj_avgs = mean(condition_matrix,2); % Average between conditions
cond_avgs = mean(condition_matrix,1); % Average between subjects
grand_avg = mean(mean(data)); 

% Build blank matrix
temp = ones(size(data,1),size(data,2)); 

% For each cell, subtract subject's overall mean and add the grand average
for subj = 1:size(data,1)
    for condition = 1:size(data,2)
        temp(subj,condition) = data(subj,condition)...
            - subj_avgs(subj) + grand_avg;
    end
end

% The above is equivalent to O'Brien & Cousineau (2014) code below:
X = data;
Y = X - repmat(mean(X'),size(X,2),1)' + mean(mean(X)); %#ok<UDIM>

% Morey (2008) correction
if nargin == 1
    J = size(data,2);
else
    fixed_facts = fixed(1);
    fixed_lvls = fixed(2);
    J = fixed_facts * fixed_lvls;
end

% Code derived from O'Brien & Cousineau (2014)
Z = sqrt(J/(J-1)) * (Y-repmat(mean(Y), size(Y,1),1)) ...
    + repmat(mean(Y), size(Y,1),1);

% Matrix includes grand average for sanity check (should be same for all)
error_matrix = horzcat(Z,ones(size(data,1),1)*grand_avg);

% Calculate standard error of the mean. This can be multiplied by 1.96 to
% give the 95% Confidence Interval
within_subj_error = nanstd(Z)/sqrt(size(data,1));

end
