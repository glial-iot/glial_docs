module.exports = {
   theme: 'custom',
   base: '/docs/',
   themeConfig: {
      nav: [
         {
            text: 'Tutorials', items: [
               { text: 'Запуск системы', link: '/start.html' }
            ],
         },
         {
            text: 'Howto guides', items: [
               { text: 'Запуск системы', link: '/start.html' }
            ],
         },
         {
            text: 'Explanation', items: [
               { text: 'Что такое GLUE', link: '/what_glue.html' },
               { text: 'Общая шина', link: '/bus.html' },
               { text: 'Система логов', link: '/logs.html' },
               { text: 'Скрипты и драйвера', link: '/scripts_and_drivers.html' },
               { text: 'Внутренности системы', link: '/inside.html' },
               { text: 'Инструменты тестирования', link: '/tests.html' }
            ],
         },
         {
            text: 'Reference', items: [
               { text: 'История изменений', link: '/changelog.html' },
               { text: 'Панель управления', link: '/panel.html' },
               { text: 'Руководство разработчика', link: '/developers.html' },
               { text: 'Язык Lua', link: '/lua.html' },
               {
                  text: 'Примеры'
               }
            ],
         },
      ],
      sidebar: "auto",
      sidebarDepth: 3,
      displayAllHeaders: true,
      lastUpdated: 'Last Updated',
      logo: '/logo.png'
   }
};




