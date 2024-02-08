#' ---
#' title: signal detection data
#' ---
#' 

library(psycho)
library(dplyr)
library(tidyr)
library(vcd)
# Simulate participants with different results at a perceptual detection task
df <- data.frame(Participant = LETTERS[1:4],
                 n_hit =  c(6, 4, 5, 8),
                 n_fa =   c(4, 2, 5, 2), 
                 n_miss = c(6, 5, 1, 2),
                 n_cr =   c(4, 9, 9, 8))

indices <- psycho::dprime(df$n_hit, df$n_fa, df$n_miss, df$n_cr)
(result <- cbind(df, indices))

with(result, {
    plot(dprime, beta, cex = 2, pch = 16,
         xlab = "d' (sensitivity)",
         ylab = expression(paste(beta, " (bias)")))
    text(dprime, beta, labels = Participant, pos = 4, xpd = TRUE)
  }
  )

df_long <- df |> pivot_longer(n_hit:n_cr, values_to = "n") |>
  mutate(signal = ifelse(name %in% c("n_hit", "n_miss"), "present", "absent"),
         response = ifelse(name %in% c("n_hit", "n_fa"), "present", "absent"))


dat <-
array(df_long$n, dim = c(2,2,4),
      dimnames = list(signal  = c("present", "absent"),
                      response= c("present", "absent"),
                      subject = LETTERS[1:4]))

fourfold(dat)
