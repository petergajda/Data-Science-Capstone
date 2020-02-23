# Coursera Data Science Capstone
## NextWord! - Shiny app for next word prediction

These code files were created as a part of the Capstone project for the [Coursera Data Science specialization](https://www.coursera.org/specializations/jhu-data-science") by the [Johns Hopkins University](https://www.jhu.edu/).
The goal of this task was to build a user-friendly app that predicts the next word based on user input.

In this github repository you find the following files

- 01 - Data preprocessing.R
- 01a - Milestone Report.Rmd
- 02 - Prediction Model.R
- 03 - Datasize Manipulation.R
- 04 - server.R
- 05 - ui.R
- 06 - Pitchdeck.Rmd

The script for data preprocessing shows a path to handle the dataset which is originally located [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip).
All findings are summed up in the [Milestone Report](https://rpubs.com/pgajda/Milestone_Report).
The prediction model contains the whole script of data manipulation in order to predict the next word based on user input. Please notice, that this file only contains the R Script which can be run independently from the shiny code.
In order to speed up calculations the preprocessed data have to be cut down to smaller peaces, since the engine would run otherwise to slow. You'll find the necessary code for that in Datasize manipulation.
server.R and ui.R contain the final shiny app code.
The [Pitchdeck](https://rpubs.com/pgajda/Next_Word_Prediction) contains a markdown file for the final pitchdeck.

---

All resulting applications and files are listed here:

- [The app: NextWord!](https://petergajda.shinyapps.io/Next_Word_Prediction/)
- [Pitchdeck](https://rpubs.com/pgajda/Next_Word_Prediction)
- [Milestone Report - Data preprocessing](https://rpubs.com/pgajda/Milestone_Report)

---

The app is based on different packages especially containing NLP. Especially these sources have to be highlighted:

- [Journal of Statistical Science, Text Mining Infrastructure in R](https://www.jstatsoft.org/article/view/v025i05)
- [Text Mining with R](https://www.tidytextmining.com/ngrams.html)
- [stringdist](https://cran.r-project.org/web/packages/stringdist/stringdist.pdf)

---

Enjoy the [NextWord!](https://petergajda.shinyapps.io/Next_Word_Prediction/) :+1: