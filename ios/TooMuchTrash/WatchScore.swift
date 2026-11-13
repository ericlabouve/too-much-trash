import Foundation

struct WatchScore {
    let defaults: UserDefaults
    let key: String
    func observe(_ ids: [UUID]) -> Int {
        var values = Set(defaults.stringArray(forKey: key) ?? [])
        values.formUnion(ids.map(\.uuidString))
        defaults.set(Array(values), forKey: key)
        return values.count
    }
    func undo(_ id: UUID) {
        var values = Set(defaults.stringArray(forKey: key) ?? [])
        values.remove(id.uuidString)
        defaults.set(Array(values), forKey: key)
    }
}
