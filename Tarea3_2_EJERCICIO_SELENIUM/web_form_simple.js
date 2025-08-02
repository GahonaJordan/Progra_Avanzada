const {By, Builder} = require('selenium-webdriver');
const assert = require("assert");

(async function firstSeleniumScript() {
    let driver;
    
    try {
        console.log('🚀 Iniciando test de Selenium...');
        
        // Inicializar el driver
        driver = await new Builder().forBrowser('chrome').build();
        console.log('✅ Driver inicializado');

        // Navegar a la página
        await driver.get('https://www.selenium.dev/selenium/web/web-form.html');
        console.log('✅ Página cargada');

        // Verificar el título
        let title = await driver.getTitle();
        assert.equal("Web form", title);
        console.log('✅ Título verificado:', title);

        // Configurar timeouts
        await driver.manage().setTimeouts({implicit: 500});

        // Encontrar elementos
        let textBox = await driver.findElement(By.name('my-text'));
        let submitButton = await driver.findElement(By.css('button'));
        console.log('✅ Elementos encontrados');

        // Interactuar con los elementos
        await textBox.sendKeys('Selenium');
        await submitButton.click();
        console.log('✅ Formulario enviado');

        // Verificar el resultado
        let message = await driver.findElement(By.id('message'));
        let value = await message.getText();
        assert.equal("Received!", value);
        console.log('✅ Mensaje verificado:', value);

        console.log('🎉 Test completado exitosamente!');

    } catch (error) {
        console.error('❌ Error durante la prueba:', error.message);
    } finally {
        if (driver) {
            await driver.quit();
            console.log('🏁 Driver cerrado');
        }
    }
})();
