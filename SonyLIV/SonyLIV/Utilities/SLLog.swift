
import Foundation

public enum SLLog {
    
    public enum Level: Int {
        case errors
        case warnings
        case info
        case debug
    }
    
    public static var level: Level = .debug
    
    public static func error(_ message: Any) {
        log(level: .errors, "error: \(message)")
        // to return error when running swift templates which is done in a different process
        if ProcessInfo().processName == "bin" {
            fputs("\(message)", stderr)
        }
    }
    
    public static func warning(_ message: Any) {
        log(level: .warnings, "warning: \(message)")
    }
    
    public static func debug(_ message: Any) {
        log(level: .debug, message)
    }
    
    public static func info(_ message: Any) {
        log(level: .info, message)
    }
    
    private static func log(level logLevel: Level, _ message: Any) {
        guard logLevel.rawValue <= SLLog.level.rawValue else { return }
        //print(message)
    }
    
   static func printLog<T>(_ message: T, file: String = #file, funcName: String = #function, lineNum: Int = #line) {
        #if DEBUG
           // let fileName: String = (file as NSString).lastPathComponent
           // print("***********Log************\n🐶🐶【\(fileName)：\(lineNum),\(funcName)】->> \(message)")
        #endif
    }

    
}
extension String: Error {}
