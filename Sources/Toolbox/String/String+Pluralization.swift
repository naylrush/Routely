//
// Copyright © 2025 Движ
//

extension String {
    public static func pluralize(number: Int, one: String, two: String, many: String) -> String {
        switch RussianPluralizationForm.pluralizeNumber(number) {
        case .zero: one // 1 кот, 31 кот
        case .one: two // 2 кота, 33 кота
        case .two: many // 5 котов, 330 котов
        }
    }
}

private enum RussianPluralizationForm {
    case zero
    case one
    case two

    static func pluralizeNumber(_ number: Int) -> Self {
        let remaining10 = number % 10
        let remaining100 = number % 100

        return if remaining10 == 1 && remaining100 != 11 {
            // form #0: ends in 1, excluding 11
            // E.g.: "1 кот"
            .zero
        } else if (remaining10 >= 2 && remaining10 <= 4) && !(remaining100 >= 12 && remaining100 <= 14) {
            // form #1: ends in 2-4, excluding 12-14
            // E.g.: "2 кота"
            .one
        } else {
            // form #2: everything else
            // E.g.: "5 котов"
            .two
        }
    }
}
