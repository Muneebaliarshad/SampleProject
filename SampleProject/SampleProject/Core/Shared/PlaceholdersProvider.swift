//
//  PlaceholdersProvider.swift
//  SampleProject
//
//  Created by Muneeb Ali on 08/06/2019.
//  Copyright © 2019 Muneeb. All rights reserved.
//

import HGPlaceholders


enum PlaceholderKey : String {
    case NoConnection = "noConnection"
    case NoResults = "noResults"
}


class CustomTableView: TableView {
    
    override func customSetup() {
        placeholdersProvider = .custom
    }
}


class CustomCollectionView: CollectionView {
    
    override func customSetup() {
        placeholdersProvider = .custom
    }
}


extension PlaceholdersProvider {
    
    static var custom: PlaceholdersProvider {
        var commonStyle = PlaceholderStyle()
        
        commonStyle.titleFont = UIFont.HelveticaNeueMedium(ofSize: 15)
        commonStyle.subtitleFont = UIFont.HelveticaNeueMedium(ofSize: 15)
        commonStyle.actionTitleFont = UIFont.HelveticaNeueBold(ofSize: 15)
        
        commonStyle.titleColor = .black
        commonStyle.subtitleColor = .gray
        commonStyle.actionTitleColor = .black
        commonStyle.actionBackgroundColor = .clear
        commonStyle.activityIndicatorColor = UIColor.ThemeColor(1.0)
        
        var noResultsData: PlaceholderData = .noResults
        noResultsData.image = nil
        noResultsData.subtitle = ""
        let noResults = Placeholder(data: noResultsData, style: commonStyle, key: .noResultsKey)
        
        
        var loadingData: PlaceholderData = .loading
        loadingData.image = nil
        loadingData.subtitle = ""
        loadingData.showsLoading = false
        loadingData.action = ""
        let loading = Placeholder(data: loadingData, style: commonStyle, key: .loadingKey)
        
        
        var errorData: PlaceholderData = .error
        errorData.image = nil
        let error = Placeholder(data: errorData, style: commonStyle, key: .errorKey)
        
        
        var noConnectionData: PlaceholderData = .noConnection
        noConnectionData.image = nil
        let noConnection = Placeholder(data: noConnectionData, style: commonStyle, key: .noConnectionKey)
        
        let placeholdersProvider = PlaceholdersProvider(loading: loading, error: error, noResults: noResults, noConnection: noConnection)
        
        return placeholdersProvider
    }
}
