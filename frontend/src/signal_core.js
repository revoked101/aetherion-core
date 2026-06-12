// Project Aetherion fine-grained telemetry signal controller
export function createQuantumSignal(initialValue) {
    let value = initialValue;
    const subscribers = new Set();
    return {
        get: () => value,
        set: (newValue) => {
            if (value !== newValue) {
                value = newValue;
                subscribers.forEach(callback => callback(value));
            }
        },
        subscribe: (callback) => {
            subscribers.add(callback);
            callback(value);
            return () => subscribers.delete(callback);
        }
    };
}
