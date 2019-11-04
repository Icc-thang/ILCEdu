//
//  StringFile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/30/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import Moya
import SkeletonView

// baseURLAPI
let baseUrl:String = "https://townwork.vn/api/"

// baseURL for image + audio
let baseUrlMedia = "https://townwork.vn/"

let avatarBase = "https://i.imgur.com/G0rDRbY.png"

// User avatar facebook
let avatar = UserDefaults.standard.string(forKey: "avatar")

// User name faecebook
let name = UserDefaults.standard.string(forKey: "name")

//api provider
let apiProvider = MoyaProvider<APIRequest>()

//place holder
let gradient = SkeletonGradient(baseColor: UIColor.colorGreen)
let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .leftRight)

//Nav Cell
let navCell = "NavCell"

//Profile Cell
let profileCell = "ProfileCell"
let processCell = "ProcessCell"
let noteCell = "NoteCell"

//Menu Cell
let menuCell = "MenuCell"

//VocabularyCell
let vocabularyCell = "VocabularyCell"
let cardCell = "CardCell"

//Lesson Cell
let lessonCell = "LessonCell"


//Menu
let menu = "MENU"
let profile = "個人ページ"
let logOut = "ログアウト"

let imageMenu = [avatar, "ic_logout"]
let titleMenu = [profile, logOut]

//tab
let tabLesson = "語彙"
let tabPractice = "練習"

// storyBoard
let loginController = "LoginController"
let registerController = "RegisterController"
let tabbarController = "TabbarController"
let vocabularyController = "VocabularyController"
let profileController = "ProfileController"
