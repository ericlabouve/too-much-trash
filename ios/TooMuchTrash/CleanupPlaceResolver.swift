import CoreLocation
import MapKit

/// Look up a human-readable area only for the marked point, never every route sample.
@MainActor enum CleanupPlaceResolver {
    static func name(for location: CLLocation) async throws -> String? {
        if #available(iOS 26.0, *) {
            guard let request = MKReverseGeocodingRequest(location: location) else { return nil }
            request.preferredLocale = .current
            return try await withTaskCancellationHandler {
                let items = try await request.mapItems
                let address = items.first?.addressRepresentations
                return cityName(city: address?.cityName, context: address?.cityWithContext, country: address?.regionName)
            } onCancel: { Task { @MainActor in request.cancel() } }
        } else {
            let geocoder = CLGeocoder()
            return try await withTaskCancellationHandler {
                let places = try await geocoder.reverseGeocodeLocation(location, preferredLocale: .current)
                guard let place = places.first else { return nil }
                return areaName(neighborhood: place.subLocality, city: place.locality,
                                region: place.administrativeArea, country: place.country)
            } onCancel: { Task { @MainActor in geocoder.cancelGeocode() } }
        }
    }
    static func areaName(neighborhood: String?, city: String?, region: String?, country: String?) -> String? {
        guard let _ = meaningfulLocality(neighborhood, country: country) ?? meaningfulLocality(city, country: country) else { return nil }
        var parts: [String] = []
        for value in [meaningfulLocality(neighborhood, country: country), meaningfulLocality(city, country: country), region] {
            if let value = cleaned(value), !parts.contains(where: { $0.caseInsensitiveCompare(value) == .orderedSame }) { parts.append(value) }
        }
        return parts.isEmpty ? nil : parts.joined(separator: ", ")
    }
    static func cityName(city: String?, context: String?, country: String?) -> String? {
        guard let city = meaningfulLocality(city, country: country) else { return nil }
        return cleaned(context) ?? city
    }
    private static func meaningfulLocality(_ value: String?, country: String?) -> String? {
        guard let value = cleaned(value) else { return nil }
        if let country = cleaned(country), value.caseInsensitiveCompare(country) == .orderedSame { return nil }
        return value
    }
    private static func cleaned(_ value: String?) -> String? {
        guard let text = value?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else { return nil }
        return String(text.prefix(240))
    }
}
