# ---------------------------------------------------------------------------- #
# “Generalized Pareto Curves: Theory and Applications”, 2017
# Thomas Blanchet, Juliette Fournier, Thomas Piketty
# ---------------------------------------------------------------------------- #
# Plot Pareto curves of the generalized Pareto distribution.
# ---------------------------------------------------------------------------- #

p <- seq(0, 1, 0.001)

# First curve: mu = 1, xi = 1/2, sigma = 0.1, ..., 0.2
mu <- 1
xi <- 1/2
sigma <- seq(0.1, 0.9, 0.2)

df <- expand.grid(list(p=p, mu=mu, xi=xi, sigma=sigma))
df$b <- 1 + df$xi*df$sigma/((1 - df$xi)*(df$sigma + (1 - df$p)^df$xi*(df$mu*df$xi - df$sigma)))

cat("Plotting: Pareto curve - generalized Pareto distribution - xi = 0.1, ..., 0.9\n")

dir.create("output/plots/generalized-pareto-distribution", showWarnings=FALSE, recursive=TRUE)
filename <- "output/plots/generalized-pareto-distribution/pareto-curve-gpd-sigma.pdf"
pdf(filename, family=plot_font, width=4.5, height=3.5)
print(ggplot(df) +
    geom_line(aes(x=p, y=b, colour=as.factor(sigma))) +
    xlab(expression(paste("rank ", italic(p)))) +
    ylab(expression(paste("inverted Pareto coefficient ", italic(b), "(", italic(p), ")"))) +
    scale_color_brewer(type="qual", palette="Set1") +
    scale_x_continuous(breaks=seq(0, 1, 0.2)) +
    ggtitle(expression(paste(mu==1, ", ", xi==1/2))) + theme_bw() +
    theme(
        legend.position = "none",
        plot.title=element_text(hjust=0.5),
        plot.background = element_rect(fill=plot_bg, color=plot_bg),
        panel.background = element_rect(fill=plot_bg),
        legend.key = element_rect(fill=plot_bg),
        text = element_text(color=plot_text_color)
    ) +
    annotate("text", label="sigma==0.1", x=0.1, y=1.28, parse=TRUE) +
    annotate("text", label="sigma==0.3", x=0.1, y=1.68, parse=TRUE) +
    annotate("text", label="sigma==0.5", x=0.1, y=2.07, parse=TRUE) +
    annotate("text", label="sigma==0.7", x=0.1, y=2.45, parse=TRUE) +
    annotate("text", label="sigma==0.9", x=0.3, y=2.70, parse=TRUE)
)
dev.off()
embed_fonts(path.expand(filename))

# Second curve: mu = 1, sigma = 1/2, xi = 0.2, ..., 0.7
mu <- 1
xi <- c(0.2, 0.5, 0.6, 0.7)
sigma <- 1/2

df <- expand.grid(list(p=p, mu=mu, xi=xi, sigma=sigma))
df$b <- 1 + df$xi*df$sigma/((1 - df$xi)*(df$sigma + (1 - df$p)^df$xi*(df$mu*df$xi - df$sigma)))

cat("Plotting: Pareto curve - generalized Pareto distribution - xi = 0.2, ..., 0.7\n")

filename <- "output/plots/generalized-pareto-distribution/pareto-curve-gpd-xi.pdf"
pdf(filename, family=plot_font, width=4.5, height=3.5)
print(ggplot(df) +
    geom_line(aes(x=p, y=b, colour=as.factor(xi))) +
    xlab(expression(paste("rank ", italic(p)))) +
    ylab(expression(paste("inverted Pareto coefficient ", italic(b), "(", italic(p), ")"))) +
    scale_x_continuous(breaks=seq(0, 1, 0.2)) +
    scale_color_brewer(type="qual", palette="Set1") +
    ggtitle(expression(paste(mu==1, ", ", sigma==1/2))) + theme_bw() +
    theme(
        legend.position = "none",
        plot.title=element_text(hjust=0.5),
        plot.background = element_rect(fill=plot_bg, color=plot_bg),
        panel.background = element_rect(fill=plot_bg),
        legend.key = element_rect(fill=plot_bg),
        text = element_text(color=plot_text_color)
    ) +
    annotate("text", label="xi==0.2", x=0.1, y=1.50, parse=TRUE) +
    annotate("text", label="xi==0.5", x=0.1, y=1.90, parse=TRUE) +
    annotate("text", label="xi==0.6", x=0.1, y=2.35, parse=TRUE) +
    annotate("text", label="xi==0.7", x=0.1, y=2.80, parse=TRUE)
)
dev.off()
embed_fonts(path.expand(filename))
