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
                        <a href="/tarot-readers" class="footer-item__list--item">Каталог тарологов</a>
                        <a href="/tarologam" class="footer-item__list--item">Тарологам</a>
                        <a href="/about-tarot" class="footer-item__list--item">О таро</a>
                    </div>
                    <div class="footer-item__list">
                        <a href="/login" class="footer-item__list--item">Личный кабинет</a>
                        <a href="/qa" class="footer-item__list--item">Вопросы</a>
                        <a href="/blog" class="footer-item__list--item">Блог</a>
                    </div>
                    <div class="footer-item__list">
                        <a href="/privacy-policy" class="footer-item__list--item">Политика конфиденциальности</a>
                        <a href="/terms-of-use" class="footer-item__list--item">Пользовательское соглашение</a>
                        <a href="/rekvizityi" class="footer-item__list--item">Реквизиты компании и порядок оплаты</a>
                    </div>
                    <div class="footer-item__list">
                        <div class="footer-item__list--item">Контакты</div>
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