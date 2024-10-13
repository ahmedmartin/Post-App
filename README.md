# Flutter clean architecture - Posts app

## #1 Intro

<span dir="rtl" align="right">
this project use flutter version 3.24.3
</span>
<br/>
<br/>

* [APK Link](https://drive.google.com/file/d/1srvG4_ro2S6HCK2NR0MJGluttjF7xM-O/view?usp=sharing)

## #2 Explain Project

<span dir="rtl" align="right">
    this project contain 3 screens 
    1- posts screen : contain all posts " you can refresh it if swap list down "
    2- post details screen : it presented when you tap on post in "posts screen" screen contain (user name , post details , comments of post " you can refresh it if swap list down ")
    3- user details screen : it presented when you tap on user name in " post details screen" screen contain (user details , posts of user " you can refresh it if swap list down ")
    it can save posts list & comments list in local storage and present post list if client offLine 
    it handle failures and have retry button to fetch data again

</span>
<br/>
<br/>

## #3 test

<span dir="rtl" align="right">
    i implement test methods for one part of project "comment"
    and all parts will work on the same way
    i use TDD for implementing test for (dataSource,model,repository,useCase) for "Comment"
    if you need to run any one of them just go to specific part and press on run icon and you can see the result of test

</span>
<br/>
<br/>



