covid-safe

In my journey to learn Flutter I decided to put together an app that shows the
latest covid stats of every country and to serve RSS news feed to the app.
The app had relies on an API which on request scraps the https://www.worldometers.info/coronavirus/ 
website and serve the data from the tables as Json to the app.

# Tools (Packages)

The flutter app uses the following packages:
1). HTTP 
        -> For making web requests and pulling flag images from https://www.flags.io/ and RSS feeds from news websites including SABC, AlJezeera and AfricaTime
2).  MDI (Material Design Icons) 
        -> MDI for extra icons that are not available in the default icon set
3). WEBFEED 
        -> WEBFEED is used to open in-app browser windows to serve the News feeds.
4). CACHEDNETWORKIMAGE 
        -> Used to cache the country flag images (Plugin could not work properly)
5). CONNECTIVITY 
        -> CONNECTIVITY is used to check whether or not there is an networ or internet 
        connection to either pull new data from sources or serve the data stored in the previous session.
URL_LAUNCHER 
        -> URL_LAUNCHER is used to launch the WEBFEED to serve news feed.
