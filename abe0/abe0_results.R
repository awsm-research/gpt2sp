library(ScottKnottESD)
library(ggplot2)

df <- read.csv("within_repo_abe0.csv")
keeps <- c("mae", "approach", "group")
df <- df[keeps]

df$approach <- as.factor(df$approach)
df$approach <- factor(df$approach, levels= c("GPT2SP", "ABE0+Hyperopt", "Deep-SE", "ABE0", "ABE0 by Choetkiertikul et al."))

df.cross <- read.csv("cross_repo_abe0.csv")
df.cross <- df.cross[keeps]
df <- rbind(df, df.cross)

# Change box plot colors by groups
ggplot(df, aes(x=reorder(approach, mae, group=group), y=mae, fill=approach)) +
  geom_boxplot()+ 
  theme_bw() + 
  theme(axis.text.x = element_text(angle = 45, vjust=1, hjust=1), legend.position="top", legend.title = element_blank()) +
  facet_grid(~group, scales = 'free_x') +
  scale_fill_brewer(direction = -1) +
  ggtitle("") + xlab("")  + ylab("MAE") + coord_cartesian(ylim=c(0, 8))

ggsave("ABE0.pdf", width=6.5,height=6.5)
