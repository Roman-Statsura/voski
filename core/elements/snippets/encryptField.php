<?php
require_once $_SERVER['DOCUMENT_ROOT'] . '/core/elements/snippets/profile/encrypt.php';

if ($modx->user->id) {
	if ($user = $modx->getObject('modUser', $modx->user->id)) {
		if ($profile = $user->getOne('Profile')) {
			$extended = $profile->get('extended');
			$extended['cvc'] = mc_encrypt($_POST['cvc'], ENCRYPTION_KEY);
			$profile->set('extended', $extended);
			$profile->save();

			if (!$profile->save()) {
				$modx->log(xPDO::LOG_LEVEL_ERROR, "Ошибка сохранения профиля");
			}
		}
	}
}