library(ggplot2)
library("dplyr") 
library(gridExtra)

par(mfrow=c(2,2))

### chart 1

df2<- data.frame(
  prediction = c("TP", "noTP"),
  n = c(43, 447))


data2 <- df2 %>% 
  arrange(desc(prediction)) %>%
  mutate(prop = n / sum(df1$n) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )


# Basic piechart
plot1<- ggplot(data2, aes(x="", y=prop, fill=prediction)) +
  geom_bar(stat="identity", width=1, color="white") +
  coord_polar("y", start=0) +
  theme_void() + ggtitle("A") +
  theme(plot.title = element_text(color="black", size=15, face="bold")) +
  theme(legend.position="bottom") + geom_text(aes(y = ypos, label = n), color = "black", size=6) +
  scale_fill_brewer(palette="Set2")


### chart 2

df1<- data.frame(
  prediction = c("SP","mTP","luTP","cTP"),
  n = c(11, 9, 2, 21))


data <- df1 %>% 
  arrange(desc(prediction)) %>%
  mutate(prop = n / sum(df1$n) *100) %>%
  mutate(ypos = cumsum(prop)- 0.5*prop )


# Basic piechart
plot2 <- ggplot(data, aes(x="", y=prop, fill=prediction)) +
  geom_bar(stat="identity", width=1, color="white") +  
  ggtitle("B") +
  theme(plot.title = element_text(color="black", size=15, face="bold")) +
  coord_polar("y", start=0) +
  theme_void() +  ggtitle("B") +
  theme(plot.title = element_text(color="black", size=15, face="bold")) +
  theme(legend.position="bottom") + geom_text(aes(y = ypos, label = n), color = "black", size=6) +
  scale_fill_brewer(palette="Set1")
 
  
  
grid.arrange(plot1, plot2, nrow=1, ncol=2)











