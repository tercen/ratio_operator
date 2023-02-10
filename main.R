library(tercen)
library(dplyr)


ctx = tercenCtx()

ctx %>% 
  select(.ri, .ci, .x, .y) %>% 
  group_by(.ri,.ci) %>%
  transmute(ratio = .y/.x) %>%
  ctx$addNamespace() %>%
  ctx$save()