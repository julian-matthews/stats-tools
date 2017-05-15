function [ within_subj_error, error_matrix] = within_subject_error( condition_one, condition_two )
% COMPUTES WITHIN-SUBJECT ERROR (SEM) for REPEATED MEASURES DESIGN
%   Input vector of first & second conditions (i.e. before & after) 
%
%   If we consider the inputs as column vectors, each row refers to a
%   different & corresponding subject (i.e. row #2 in condition one refers 
%   to the subject in row #2 of condition two).
%   
%   Script computes subject averages and grand average, removes between
%   subject variability by subtracting subject average from each cell +
%   adding grand average, and computes standard error of the mean from
%   these relative values.
%   
%   Process adapted from CogSci.nl
%   See: http://www.cogsci.nl/blog/tutorials/156-an-easy-way-to-create-graphs-with-within-subject-error-bars
%
%   Julian Matthews (2017)

temp = vertcat(condition_one,condition_two)'; % Assume row vector input

if any(size(temp)==1)
    temp = horzcat(condition_one,condition_two); % If column vector input
end

condition_matrix = temp; 
subj_avgs = mean(condition_matrix,2); % Average between conditions
grand_avg = mean(subj_avgs); 

% For each cell, subtract subject's overall mean and add the grand average
for subj = 1:length(condition_one)
    temp(subj,1) = temp(subj,1) - subj_avgs(subj) + grand_avg;
    temp(subj,2) = temp(subj,2) - subj_avgs(subj) + grand_avg;
end

% Matrix includes grand average for sanity check (should be same for all)
error_matrix = horzcat(temp,ones(length(condition_one),1)*grand_avg,subj_avgs);

% Calculate standard error of the mean. This can be multiplied by 1.96 to
% give the 95% Confidence Interval
within_subj_error = std(temp)/length(condition_one);

end
