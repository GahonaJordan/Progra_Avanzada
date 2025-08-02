//importar los modulos de selenium
const { Builder, By, Key, until } = require('selenium-webdriver');

(async function registerTest() {
    //inicializar el navegador
    let driver = await new Builder().forBrowser('chrome').build();
    
    try {
        // 1. Ir al formulario de prueba
        await driver.get('https://demoqa.com/automation-practice-form');
        
        // Esperar a que la página se cargue completamente
        await driver.sleep(3000);

        // 2. Llenar campos del formulario
        await driver.findElement(By.id('firstName')).sendKeys('Jordan');
        await driver.findElement(By.id('lastName')).sendKeys('Gahona');
        await driver.findElement(By.id('userEmail')).sendKeys('jordan@example.com');

        // 3. Seleccionar género (radio) - Solucionando problema con anuncios
        // Opción 1: Hacer scroll hasta el elemento antes de hacer clic
        const genderElement = await driver.findElement(By.css('label[for="gender-radio-1"]'));
        await driver.executeScript("arguments[0].scrollIntoView(true);", genderElement);
        await driver.sleep(1000); // Esperar a que se cargue
        
        // Opción 2: Usar JavaScript para hacer clic directamente
        await driver.executeScript("arguments[0].click();", genderElement);

        // 4. Número de teléfono
        await driver.findElement(By.id('userNumber')).sendKeys('0991234567');

        // 5. Hacer scroll para ver el botón Submit
        await driver.executeScript("window.scrollTo(0, document.body.scrollHeight);");
        await driver.sleep(1000); // Esperar a que se complete el scroll

        // 6. Click en el botón "Submit"
        await driver.findElement(By.id('submit')).click();

        // 7. Obtener el título del modal
        const modalTitle = await driver.findElement(By.id('example-modal-sizes-title-lg')).getText();
        console.log('\nTítulo del modal:', modalTitle);

        // 8. Obtener todo el texto del resumen del modal
        const modalBody = await driver.findElement(By.className('table-responsive')).getText();
        console.log('\n📋 Contenido del modal:\n' + modalBody);

        // 9. Verificar si el nombre completo aparece
        const fullName = 'Jordan Gahona';
        if (modalBody.includes(fullName)) {
            console.log(`Test exitoso: el nombre "${fullName}" aparece en el resumen.`);
        } else {
            console.log(`Test fallido: el nombre "${fullName}" no se encontró en el resumen.`);
        }

    } catch (error) {
        console.error('Error durante la prueba:', error);
    } finally {
        // 10. Cerrar el navegador
        await driver.quit();
    }
})();