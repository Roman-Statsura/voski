<footer class="footer">
    <div class="container footer-container">
        <div class="footer-container__content footer-content">
            <div class="footer-content__block">
                <div class="footer-content__block-item footer-item footer-logo">
                    <a href="/" class="footer-item__link">
                        {'@FILE chunks/globals/logo.tpl' | chunk : [
                            'fill' => '#292F36'
                        ]}
                    </a>
                    <div class="footer-item__socials">
                        <a href="#" class="footer-item__socials--link">
                            {'@FILE chunks/icons/icon-instagram.tpl' | chunk}
                        </a>
                        <a href="#" class="footer-item__socials--link">
                            {'@FILE chunks/icons/icon-facebook.tpl' | chunk}
                        </a>
                        <a href="#" class="footer-item__socials--link">
                            {'@FILE chunks/icons/icon-vk.tpl' | chunk}
                        </a>
                    </div>
                </div>
                <div class="footer-content__block-item footer-item footer-menu">
                    <div class="footer-item__list">
                        <a href="/{$_modx->makeUrl(2)}" class="footer-item__list--item">Каталог тарологов</a>
                        <a href="/{$_modx->makeUrl(3)}" class="footer-item__list--item">Тарологам</a>
                        <a href="/{$_modx->makeUrl(4)}" class="footer-item__list--item">О таро</a>
                    </div>
                    <div class="footer-item__list">
                        <a href="/{$_modx->makeUrl(22)}" class="footer-item__list--item">Личный кабинет</a>
                        <a href="/{$_modx->makeUrl(6)}" class="footer-item__list--item">Вопросы</a>
                        <a href="/{$_modx->makeUrl(5)}" class="footer-item__list--item">Блог</a>
                    </div>
                    <div class="footer-item__list">
                        <a href="/{$_modx->makeUrl(7)}" class="footer-item__list--item">Политика конфиденциальности</a>
                        <a href="/{$_modx->makeUrl(42)}" class="footer-item__list--item">Пользовательское соглашение</a>
                        <a href="/{$_modx->makeUrl(9)}" class="footer-item__list--item">Реквизиты компании и порядок оплаты</a>
                    </div>
                    <div class="footer-item__list">
                        <a href="/{$_modx->makeUrl(10)}" class="footer-item__list--item">Контакты</a>
                        <a href="tel:" class="footer-item__list--item">+7 (900) 123-23-23</a>
                        <a href="mailto:support@voski.com" class="footer-item__list--item">support@voski.com</a>
                    </div>
                </div>
            </div>
            <div class="footer-content__block footer-content__bottom">
                <div class="footer-content__block-item footer-item">
                    <p class="footer-item__paragraph">
                        Настоящий сайт носит исключительно информационный характер.<br>
                        Все права на публикуемые на сайте материалы принадлежат "Voski" © 2021.
                    </p>
                </div>
                <div class="footer-content__block-item footer-item">
                    <a href="#" class="footer-item__link">
                        <div class="footer-item__link-title">Служба поддержки</div>
                        <div class="footer-item__link-state"></div>
                    </a>
                </div> 
            </div>
        </div>
    </div>
</footer>