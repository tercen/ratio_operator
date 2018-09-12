library(tercen)
library(dplyr)

(ctx = tercenCtx()) %>% 
  select(.x, .y) %>% 
  transmute(ratio = .y/.x) %>%
  ctx$addNamespace() %>%
  ctx$save()
  