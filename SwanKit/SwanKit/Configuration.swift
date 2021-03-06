import Foundation
import TSCBasic

/// Holds the complete set of configured values and defaults.
public struct Configuration {
        
    public let rules: [Rule]
    
    public let reporter: Reporter
    
    public let included: [AbsolutePath]
    
    public let excluded: [AbsolutePath]
    
    public let blacklistFiles: [String]
    
    public let blacklistSymbols: [String]
    
    public let outputFile: AbsolutePath
    
    /// The  project path
    public let projectPath: AbsolutePath
    
    /// The project index storePath path
    public let indexStorePath: String
    
    /// The project index database path
    public var indexDatabasePath: String
    
    internal init(projectPath: AbsolutePath,
                  indexStorePath: String,
                  indexDatabasePath: String? = nil,
                  rules: [Rule],
                  reporter: Reporter,
                  included: [AbsolutePath],
                  excluded: [AbsolutePath],
                  blacklistFiles: [String],
                  blacklistSymbols: [String],
                  outputFile: AbsolutePath) {
        self.projectPath = projectPath
        self.indexStorePath = indexStorePath
        self.indexDatabasePath = indexDatabasePath ?? NSTemporaryDirectory() + "index_\(getpid())"
        self.rules = rules
        self.reporter = reporter
        self.included = included
        self.excluded = excluded
        self.blacklistFiles = blacklistFiles
        self.blacklistSymbols = blacklistSymbols
        self.outputFile = outputFile
    }
    
    public init(projectPath: AbsolutePath, indexStorePath: String = "", indexDatabasePath: String? = nil, reportType: ReporterType = .console) {
        let reporter = ReporterFactory.make(reportType)
        let rules = RuleFactory.make()
        let outputFilePath = AbsolutePath(projectPath.asURL.path).appending(component: "swan.output.pdf")
        self.init(projectPath: projectPath,
                  indexStorePath: indexStorePath,
                  indexDatabasePath: indexDatabasePath,
                  rules: rules,
                  reporter: reporter,
                  included: ([""]).map{ projectPath.appending(component: $0)},
                  excluded: ([]).map{ projectPath.appending(component: $0)} ,
                  blacklistFiles: [],
                  blacklistSymbols: [],
                  outputFile: outputFilePath)
    }
}
