export class AxiosConvertor {
    static convertSnakeToCamel<T>(obj: T | undefined): T {
        if (Array.isArray(obj)) {
            return obj.map((v) => this.convertSnakeToCamel(v)) as T;
        } else if (
            obj !== null &&
            obj !== undefined &&
            obj.constructor === Object
        ) {
            return Object.keys(obj as object).reduce(
                (result, key) => ({
                    ...result,
                    [key.replace(/([-_][a-z])/g, (group) =>
                        group.toUpperCase().replace('-', '').replace('_', ''),
                    )]: this.convertSnakeToCamel((obj as any)[key]),
                }),
                {},
            ) as T;
        }
        return obj as T;
    }

    static convertCamelToSnake<T>(obj: T | undefined): T {
        if (Array.isArray(obj)) {
            return obj.map((v) => this.convertCamelToSnake(v)) as T;
        } else if (
            obj !== null &&
            obj !== undefined &&
            obj.constructor === Object
        ) {
            return Object.keys(obj as object).reduce(
                (result, key) => ({
                    ...result,
                    [key.replace(
                        /[A-Z]/g,
                        (letter) => `_${letter.toLowerCase()}`,
                    )]: this.convertCamelToSnake((obj as any)[key]),
                }),
                {},
            ) as T;
        }
        return obj as T;
    }
}

export default AxiosConvertor;