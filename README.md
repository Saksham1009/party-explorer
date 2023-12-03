# 🎉 party-explorer
A small party explorer app that helps you search for parties and add new random ones

### The project sits inside the folder party-exporer above this README file (just to avoid confusion between repo and project later if run locally)

## Installation
Installation and setting up the project should be pretty simple:
1) Clone the repository
2) Open the xcodeproj file to launch the project all together
3) Should be able to build and run party-exporer project, for reference `party_exporerApp` file is the root file 

## A quick walkthrough

Consists of mainly 2 screens:

<img width="344" alt="Screenshot 2023-12-03 at 7 47 21 AM" src="https://github.com/Saksham1009/party-explorer/assets/64316238/c74c34af-e475-47f5-b1ba-a23e0c9cb2aa">

1) The feed -> This screen looks like this, initially with 3 random parties represented by cards containing all the information required (name, image, price, start and end date) from the mock data stored inside the project

   Also has a search bar at the top which helps filter parties in the feed on the basis of their names (pretty simple contain search)

   When there are results available:
<img width="335" alt="Screenshot 2023-12-03 at 7 48 53 AM" src="https://github.com/Saksham1009/party-explorer/assets/64316238/49fc008b-bd5c-4046-ac26-50e35ec333ce">

   When there are not:

<img width="331" alt="Screenshot 2023-12-03 at 7 49 10 AM" src="https://github.com/Saksham1009/party-explorer/assets/64316238/baf1e4b3-5d6f-4878-8d19-322d45fc67fb">


   Also have the Add party button right next to it which takes us to the party creater screen

3) The party creater -> This modally presented screen helps users create new random parties, wherein the names and images are prefilled from the mock data in the project, they can add price, start date and end date if they want otherwise publish the party which will appear on the feed after that

If the user chooses to not put a end date:

<img width="347" alt="Screenshot 2023-12-03 at 7 50 46 AM" src="https://github.com/Saksham1009/party-explorer/assets/64316238/0f984dc7-9f20-452c-99a5-db3288d3869e">

If they chose otherwise:

<img width="348" alt="Screenshot 2023-12-03 at 7 51 20 AM" src="https://github.com/Saksham1009/party-explorer/assets/64316238/0561500d-50c3-4834-b0c3-eb8fbe65803d">

## Last comments

1) This is not supported for other devices or not properly altered for different resolutions/sizes (tested primarirly on iphone 14 pro max but should be good with most iphones)
2) Minimum deployment target version is iOS 16
3) TCA added in SPM so should not require any additional install through coco pods or anything
4) I AM NOT AT ALL a designs guy so I tried my best to come up with the best designs I could lol
5) Let me know if you have any comments @sakshamdua103@gmail.com


