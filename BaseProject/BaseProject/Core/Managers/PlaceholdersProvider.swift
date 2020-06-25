//
//  PlaceholdersProvider.swift
//  BaseProject
//
//  Created by Muneeb Ali on 22/06/2020.
//  Copyright © 2020 Muneeb Ali. All rights reserved.
//

import HGPlaceholders


class MATableView: TableView {
    override func customSetup() {
        placeholdersProvider = .maProject
    }
}


class MACollectionView: CollectionView {
    override func customSetup() {
        placeholdersProvider = .maProject
    }
}


extension PlaceholdersProvider {

    static var maProject: PlaceholdersProvider {
        
        var commonStyle = PlaceholderStyle()
        
        commonStyle.titleFont = UIFont.RobotoMedium(ofSize: 18)
        commonStyle.subtitleFont = UIFont.RobotoMedium(ofSize: 12)
        commonStyle.actionTitleFont = UIFont.RobotoMedium(ofSize: 15)

        commonStyle.titleColor = UIColor.black
        commonStyle.subtitleColor = UIColor.black
        commonStyle.actionTitleColor =  .white
        commonStyle.actionBackgroundColor = .gray
        commonStyle.activityIndicatorColor = .gray

        
        
        var noResultStyle = PlaceholderStyle()
        
        noResultStyle.titleFont = UIFont.RobotoMedium(ofSize: 18)
        noResultStyle.subtitleFont = UIFont.RobotoMedium(ofSize: 12)
        noResultStyle.actionTitleFont = UIFont.RobotoMedium(ofSize: 15)

        noResultStyle.titleColor = UIColor.black
        noResultStyle.subtitleColor = UIColor.black
        noResultStyle.actionTitleColor =  .clear
        noResultStyle.actionBackgroundColor = .clear
        noResultStyle.activityIndicatorColor = .gray
        
        var noResultsData: PlaceholderData = .noResults
        noResultsData.image = nil
        noResultsData.title = "No Record Found"
        noResultsData.subtitle = "Try a different search"
        noResultsData.action = ""
        let noResults = Placeholder(data: noResultsData, style: noResultStyle, key: .noResultsKey)


        //Here Loding Type is used to display No Playlist Error in MyPlayList Screen
        var loadingData: PlaceholderData = .loading
        loadingData.image = nil
        loadingData.title = "No Playlist"
        loadingData.subtitle = "Please create a playlist"
        loadingData.showsLoading = false
        loadingData.action = nil
        
        let loading = Placeholder(data: loadingData, style: commonStyle, key: .loadingKey)


        var errorData: PlaceholderData = .error
        errorData.image = nil
        errorData.title = "Something went wrong"
        errorData.subtitle = "Please try again later"
        let error = Placeholder(data: errorData, style: commonStyle, key: .errorKey)


        var noConnectionData: PlaceholderData = .noConnection
        noConnectionData.image = nil
        noConnectionData.title = "No Internet Connection"
        noConnectionData.subtitle = "Please connect to internet and retry"
        let noConnection = Placeholder(data: noConnectionData, style: commonStyle, key: .noConnectionKey)
        
        let placeholdersProvider = PlaceholdersProvider(loading: loading, error: error, noResults: noResults, noConnection: noConnection)
        
        return placeholdersProvider
    }
}
