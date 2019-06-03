# With @dsquintana

# If you were working with 80% power, and you ran 100 studies. 80 would be significant and 20 wouldn't be.

# G*Power doesn't work for reproducibility

# Three important bits to power: Participant numbers, alpha level (p-value), expected effect size
# If you know any 3 of these parameters, you can get the other one (e.g., statistical power, alpha level, effect size ==> sample size required a priori)

library('pwr')
library(ggplot2)

theme_set(theme_bw())

# Cohen's conventions were designed as a fallback when you had no idea re: effect size to use
# "Ideally, the effect size you want to use is the effect size you want to show"
# "In some fields, there are effect sizes you are interested in"

# Consider the "smallest effect size of interest"

# "With typical p-value testing there's no way to provide support for null 
# but what you can do with equivalence testing is you can reject effects 
# as large or larger than a smallest effect size of interest"

# For instance, a correlation of 0.1 is, for all intents and purposes, meaningless

cohen.ES(
  test = 't',
  size = 'small'
)

# power for correlations --------------------------------------------------

r_power <- pwr.r.test(
  r = 0.3,
  sig.level = 0.05,
  power = 0.8,
  alternative = 'greater'
)

print(r_power)
plot(r_power)


# power for t-test --------------------------------------------------------

# Note difference when type of test is 'paired' or 'two.sample'
# It is very 'powerful' to use the paired design
t_power <-  pwr.t.test(
  d = 0.5,
  sig.level = 0.05,
  power = 0.8,
  type = 'paired',
  alternative = 'greater'
)

print(t_power)
plot(t_power)

anova_power <- pwr.anova.test(
  k = 4,
  f = 0.15,
  sig.level = 0.05,
  power = 0.8
)

print(anova_power)
plot(anova_power)


# TOSTER power ------------------------------------------------------------

library('TOSTER')

TOST_corr <- powerTOSTr(
  alpha = 0.05,
  statistical_power = 0.9,
  low_eqbound_r = 0.1,
  high_eqbound_r = 0.1
)
