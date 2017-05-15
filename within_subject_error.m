function [ within_subj_error, error_matrix] = within_subject_error( condition_one, condition_two )
% COMPUTES WITHIN-SUBJECT ERROR (SEM) for REPEATED DESIGN
%   Input vector of first & second conditions (i.e. before & after) 

%   If we consider the inputs as column vectors, each row refers to a
%   different & corresponding subject (i.e. row #2 in condition one refers 
%   to the subject in row #2 of condition two).
%   
%   Script computes subject averages and grand average, removes between
%   subject variability by subtracting subject average from each cell +
%   adding grand average, and computes standard error of the mean from
%   these relative values.
%
%   See: http://www.cogsci.nl/blog/tutorials/156-an-easy-way-to-create-graphs-with-within-subject-error-bars

temp = vertcat(condition_one,condition_two)'; % Assume row vector input

if any(size(temp)==1)
    temp = horzcat(condition_one,condition_two);
end

condition_matrix = temp;
subj_avgs = mean(condition_matrix,2);
grand_avg = mean(subj_avgs);

for subj = 1:length(condition_one)
    temp(subj,1) = temp(subj,1) - subj_avgs(subj) + grand_avg;
    temp(subj,2) = temp(subj,2) - subj_avgs(subj) + grand_avg;
end

error_matrix = horzcat(temp,ones(length(condition_one),1)*grand_avg,subj_avgs);

within_subj_error = std(temp)/length(condition_one);

end
