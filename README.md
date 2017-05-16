# Julian's *stats-tools*
Some simple analysis tools coded in MATLAB, currently contains:

### **Objective Performance**: 
`type1auc.m`

A novel script for calculating **a-prime** objective performance using signal detection theory. Includes outputs for plotting ROC curve.

### **Metacognitive Accuracy**: 
`type2roc.m` 

A minor update on the MATLAB code supplied in the 2014 Frontiers article *How To Measure Metacognition* by Stephen Fleming and Hakwan Lau. Process is identical to their code but have added some comments.  

### **Within-Subjects Standard Error of the Mean**: 
`within_subject_error.m`

A novel script for calculating within-subject error bars for a repeated measures design with multiple conditions. Adapted from [Cousineau (2008)](http://www.tqmp.org/RegularArticles/vol01-1/p042/p042.pdf) and [O'Brien & Cousineau (2014)](https://doaj.org/article/f4ebea6750c94e34b65319ad093b57a1). Useful for adding SEM error bars to plots in MATLAB. These can be converted to approximate 95% CIs if multiplied by 1.96. 

Credit to [CogSci.nl](http://www.cogsci.nl/blog/tutorials/156-an-easy-way-to-create-graphs-with-within-subject-error-bars) for a simple description of the Cousineau (2008) technique with two conditions.  

### **Response Screen**
`confidence_screen.m`

This needs some tweaking as of June 2017 but have added code for the typical MoNoC 4-level confidence screen. 

![alt_text][avatar]

[avatar]: https://avatars0.githubusercontent.com/u/18410581?v=3&s=96 "Yup, there's some text here"
