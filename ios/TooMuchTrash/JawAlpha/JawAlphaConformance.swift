import Foundation

enum JawAlphaConformance {
    static func run() {
        let folder = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("AlphaConformance")
        let report = folder.appendingPathComponent("report.json")
        do {
            let index = try JSONSerialization.jsonObject(with: Data(contentsOf: folder.appendingPathComponent("index.json"))) as! [String: Any]
            let clips = index["clips"] as! [[String: Any]]
            guard clips.count == 6 else { throw ClientError.invalidResponse }
            var records: [[String: Any]] = []
            for clip in clips {
                let detector = try JawAlphaBridge(directory: Bundle.main.resourceURL!)
                let name = clip["file"] as! String
                let frames = try Data(contentsOf: folder.appendingPathComponent(name))
                let timestamps = clip["timestamps"] as! [Double]
                let expected = clip["expected_scores"] as! [Double]
                guard frames.count == timestamps.count * 320 * 240 else { throw ClientError.invalidResponse }
                let sensors = clip["sensors"] as! [String: [String: Any]]
                var events: [[Any]] = []
                var maxError = 0.0
                for (i, time) in timestamps.enumerated() {
                    func samples(_ name: String) -> ([NSNumber], [NSNumber]) {
                        let stream = sensors[name]!
                        let ts = stream["times"] as! [Double], vs = stream["vectors"] as! [[Double]]
                        let indices = ts.indices.filter { ts[$0] <= time }.suffix(33)
                        return (indices.map { NSNumber(value: ts[$0]) }, indices.flatMap { vs[$0].map(NSNumber.init(value:)) })
                    }
                    let (gt, gv) = samples("gyroscope"), (at, av) = samples("accelerometer")
                    var score = 0.0
                    let event = detector.step(frames.subdata(in: (i*76800)..<((i+1)*76800)), timestamp: time, gyroTimes: gt, gyroValues: gv, accelTimes: at, accelValues: av, score: &score)
                    maxError = max(maxError, abs(score-expected[i]))
                    if event != 0 { events.append([event == 1 ? "close" : "open", time]) }
                }
                let expectedEvents = clip["expected_events"] as! [[Any]]
                let same = (events as NSArray).isEqual(to: expectedEvents)
                records.append(["fixture": name, "frames": timestamps.count, "max_absolute_score_error": maxError, "events_match": same, "passed": maxError <= 1e-6 && same])
            }
            let output: [String: Any] = ["model_id": "jaw-r59-independent-motion-alpha1", "status": records.allSatisfy { $0["passed"] as? Bool == true } ? "passed" : "failed", "clips": records, "test_read": false, "live_preprocessing_validated": false]
            try JSONSerialization.data(withJSONObject: output, options: [.sortedKeys, .prettyPrinted]).write(to: report, options: .atomic)
        } catch {
            try? JSONSerialization.data(withJSONObject: ["status": "failed", "error": error.localizedDescription]).write(to: report, options: .atomic)
        }
    }
}
