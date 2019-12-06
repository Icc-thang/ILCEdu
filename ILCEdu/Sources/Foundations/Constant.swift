//
//  StringFile.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/30/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import Foundation
import UIKit
import Moya
import SDWebImage
import RxSwift

// baseURLAPI
let baseUrl:String = "https://townwork.vn/api/"

// baseURL for image + audio
let baseUrlMedia:String = "https://townwork.vn/"

let avatarBase = "https://i.imgur.com/G0rDRbY.png"

// User avatar facebook
let avatar = UserDefaults.standard.string(forKey: "avatar")

// User name faecebook
let name = UserDefaults.standard.string(forKey: "name")

//api provider
let apiProvider = MoyaProvider<APIRequest>()

//DisposeBag
let disposeBag = DisposeBag()

//Profile Cell
let profileCell = "ProfileCell"
let processCell = "ProcessCell"
let noteCell = "NoteCell"

//Menu Cell
let menuCell = "MenuCell"

//VocabularyCell
let vocabCell = "VocabCell"
let meaningVocabCell = "MeaningVocabCell"
let imageVocabCell = "ImageVocabCell"
let buttonVocabCell = "ButtonVocabCell"

//Lesson Cell
let lesCell = "LessonCell"

//practice Cell
let practiceCell = "PracticeCell"
let sectionCell = "SectionCell"

//Controller
let loginController = "LoginController"
let registerController = "RegisterController"
let tabbarController = "TabbarController"
let vocabController = "VocabController"
let profileController = "ProfileController"
let questionController = "QuestionController"

//QuestionCell
let questionCell = "QuestionCell"

//TextQuestionCell
let textQuestionCell = "TextQuestionCell"

//AudioQuestionCell
let audioQuestionCell = "AudioQuestionCell"

//ImageQuestionCell
let imageQuestionCell = "ImageQuestionCell"

//SuggestCell
let suggestCell = "SuggestCell"

//AnswerCell
let answerCell = "AnswerCell"

//NextCell
let nextCell = "NextCell"

//Menu
let menu = "MENU"
let profile = "個人ページ"
let logOut = "ログアウト"

let imageMenu = [avatar, "ic_logout"]
let titleMenu = [profile, logOut]

//tab
let tabLesson = "語彙"
let tabPractice = "練習"
let tabMenu = "メニュー"

let screenWidth = UIScreen.main.bounds.size.width
