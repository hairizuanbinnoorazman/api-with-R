library(googlesheets4)
library(googledrive)

# Doing up authentication on application start
googlesheets4::sheets_auth(path="google-auth.json")
googledrive::drive_auth(path="google-auth.json")

doAnalysis <- function() {
    lol = read_sheet("https://docs.google.com/spreadsheets/d/1hRTT_ygAPQikJgB-U_iFmK3S5KAWP7GYjXPE_HbwUrs/edit#gid=0")
    write.csv(lol, "lol.csv")

    file = drive_upload("lol.csv", name="AAZZ")
    drive_share(file, role="reader", type="user", emailAddress="hairizuanbinnoorazman@gmail.com")
    return("complete")
}
