#if os(Linux)

import Glibc

public let systemSignal = Glibc.signal
public let SIGPIPE = Glibc.SIGPIPE
public let SIGINT = Glibc.SIGINT
public let SIGTERM = Glibc.SIGTERM
public let SIG_IGN = Glibc.SIG_IGN
#else

import Darwin

public let systemSignal = Darwin.signal
public let SIGPIPE = Darwin.SIGPIPE
public let SIGINT = Darwin.SIGINT
public let SIGTERM = Darwin.SIGTERM
public let SIG_IGN = Darwin.SIG_IGN
#endif

import Dispatch
import SwiftyRequest
import HeliumLogger
import LoggerAPI

// Logging
setbuf(stdout, nil)
let helium = HeliumLogger(.debug)
helium.details = true
Log.logger = helium

func stathatTrackEZCount(user: String, name: String, count c: Int) {
    Log.info("\(#function) \(name): \(c)")
    DispatchQueue.global().async {
        let request = RestRequest(method: .post, url: "https://api.stathat.com/ez")
        let stat = ["stat": name, "count": c] as [String : Any]
        let json = JSONWrapper(dictionary: ["ezkey": user, "data": [stat]])
        request.messageBody = try? json.serialize()
        request.response() { data, response, error in
                if let e = error {
                    Log.error("ERROR: failed to stathatTrackEZCount stat: '\(stat)', request: \(request), error: \(e)")
                } else if let d = data, let s = String(data: d, encoding: .utf8) {
                    Log.debug("stathatTrackEZCount: response status code: \(response?.statusCode ?? -1), data: '\(s)'")
                }
        }
    }
}

let timerSource = DispatchSource.makeTimerSource()
timerSource.setEventHandler(handler: {
    
    Log.info("Going to make a bunch of HTTPS POST requests every 30 seconds")
    Log.info("CTRL-C to terminate")

    for _ in 0...30 {
        stathatTrackEZCount(user: "REPLACE_WITH_YOUR_STATHAT_API_KEY", name: "xxx", count: 1)
    }
})

timerSource.schedule(deadline: .now(), repeating: 30)
timerSource.resume()

dispatchMain()
