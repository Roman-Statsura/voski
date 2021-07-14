function paymentReasonError(reason) {
    let reasonValue = "";

    switch (reason) {
        case '3d_secure_failed':
            reasonValue = "Не пройдена аутентификация по 3-D Secure.";
            break;
        case 'call_issuer':
            reasonValue = "Оплата данным платежным средством отклонена по неизвестным причинам. Обратитесь в организацию, выпустившую ваше платежное средство";
            break;
        case 'card_expired':
            reasonValue = "Истек срок действия банковской карты. Обратитесь в организацию, выпустившую ваше платежное средство.";
            break;
        case 'country_forbidden':
            reasonValue = "Нельзя заплатить банковской картой, выпущенной в этой стране.";
            break;
        case 'deal_expired':
            reasonValue = "Закончился срок жизни сделки.";
            break;
        case 'expired_on_capture':
            reasonValue = "Истек срок списания оплаты у двухстадийного платежа. ";
            break;
        case 'expired_on_confirmation':
            reasonValue = "Истек срок оплаты: клиент не подтвердил платеж за время, отведенное на оплату выбранным способом.";
            break;
        case 'fraud_suspected':
            reasonValue = "Платеж заблокирован из-за подозрения в мошенничестве.";
            break;
        case 'general_decline':
            reasonValue = "Причина не детализирована. Обратитесь к инициатору отмены платежа за подробностями";
            break;
        case 'identification_required':
            reasonValue = "Превышены ограничения на платежи для кошелька ЮMoney.";
            break;
        case 'insufficient_funds':
            reasonValue = "Не хватает денег для оплаты.";
            break;
        case 'internal_timeout':
            reasonValue = "Технические неполадки на стороне ЮKassa: не удалось обработать запрос в течение 30 секунд. Повторите пожалуйста платеж позднее.";
            break;
        case 'invalid_card_number':
            reasonValue = "Неправильно указан номер карты.";
            break;
        case 'invalid_csc':
            reasonValue = "Неправильно указан код CVV2 (CVC2, CID).";
            break;
        case 'issuer_unavailable':
            reasonValue = "Организация, выпустившая платежное средство, недоступна.";
            break;
        case 'payment_method_limit_exceeded':
            reasonValue = "Исчерпан лимит платежей для данного платежного средства или вашего магазина.";
            break;
        case 'payment_method_limit_exceeded':
            reasonValue = "Исчерпан лимит платежей для данного платежного средства или магазина.";
            break;
        case 'payment_method_restricted':
            reasonValue = "Запрещены операции данным платежным средством. Обратитесь в организацию, выпустившую ваше платежное средство";
            break;
        case 'permission_revoked':
            reasonValue = "Нельзя провести безакцептное списание: пользователь отозвал разрешение на автоплатежи.";
            break;
        case 'unsupported_mobile_operator':
            reasonValue = "Нельзя заплатить с номера телефона этого мобильного оператора.";
            break;
        default:
            reasonValue = "Something Error! Пожалуйста обратитесь в тех.поддержку сайта!";
            break;
    }

    return reasonValue;
}