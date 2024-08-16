const fs = require('fs');
const path = require('path');
const xlsx = require('xlsx');

// Função para verificar chamadas às integration procedures no campo ipMethod (VlocityCards)
function checkIntegrationProceduresVlocityCards(json, procedures) {
    const checkRecursively = (obj) => {
        if (typeof obj === 'object' && obj !== null) {
            for (const key in obj) {
                if (obj.hasOwnProperty(key)) {
                    if (typeof obj[key] === 'object' && obj[key] !== obj) { // Evita loops recursivos em objetos circulares
                        if (checkRecursively(obj[key])) {
                            return true;
                        }
                    } else if (key === 'ipMethod' && typeof obj[key] === 'string') {
                        console.log(`Found ipMethod: ${obj[key]}`);
                        if (procedures.includes(obj[key])) {  // Comparação exata
                            console.log(`Exact match found: ${obj[key]}`);
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    };

    return checkRecursively(json);
}

// Função para verificar chamadas às integration procedures no campo integrationProcedureKey (Omniscripts)
function checkIntegrationProceduresOmniscripts(json, procedures) {
    const checkRecursively = (obj) => {
        if (typeof obj === 'object' && obj !== null) {
            for (const key in obj) {
                if (obj.hasOwnProperty(key)) {
                    if (typeof obj[key] === 'object' && obj[key] !== obj) { // Evita loops recursivos em objetos circulares
                        if (checkRecursively(obj[key])) {
                            return true;
                        }
                    } else if (key === 'integrationProcedureKey' && typeof obj[key] === 'string') {
                        console.log(`Found integrationProcedureKey: ${obj[key]}`);
                        if (procedures.includes(obj[key])) {  // Comparação exata
                            console.log(`Exact match found: ${obj[key]}`);
                            return true;
                        }
                    }
                }
            }
        }
        return false;
    };

    return checkRecursively(json);
}

// Função para buscar e verificar JSONs de VlocityCards de forma recursiva
function findComponents(basePath, type, getProcedures) {
    let components = [];

    const directories = fs.readdirSync(basePath);
    directories.forEach(directory => {
        const dirPath = path.join(basePath, directory);
        if (fs.statSync(dirPath).isDirectory() && directory.startsWith('val')) {
            console.log(`Checking directory: ${dirPath}`);
            const files = fs.readdirSync(dirPath);
            files.forEach(file => {
                const filePath = path.join(dirPath, file);
                if (fs.statSync(filePath).isFile() && path.extname(file) === '.json') {
                    console.log(`Checking file: ${filePath}`);
                    const data = fs.readFileSync(filePath, 'utf-8');
                    let json;
                    try {
                        json = JSON.parse(data);
                    } catch (error) {
                        console.error(`Error parsing JSON from file: ${filePath}`, error);
                        return;
                    }

                    const procedures = getProcedures(directory);
                    console.log(`Procedures to check: ${procedures}`);

                    // Verificar todo o JSON recursivamente usando a função para VlocityCards
                    if (checkIntegrationProceduresVlocityCards(json, procedures)) {
                        components.push({ type, name: `${directory}/${file}` });
                        console.log(`Found in json: ${directory}/${file}`);
                    }
                }
            });
        }
    });

    return components;
}

// Função para buscar e verificar JSONs de Omniscripts de forma recursiva
function findOmniscripts(basePath, type, getProcedures) {
    let components = [];

    const directories = fs.readdirSync(basePath);
    directories.forEach(directory => {
        const dirPath = path.join(basePath, directory);
        if (fs.statSync(dirPath).isDirectory()) { 
            console.log(`Checking directory: ${dirPath}`);
            const files = fs.readdirSync(dirPath);
            files.forEach(file => {
                const filePath = path.join(dirPath, file);
                if (fs.statSync(filePath).isFile() && path.extname(file) === '.json') {
                    console.log(`Checking file: ${filePath}`);
                    const data = fs.readFileSync(filePath, 'utf-8');
                    let json;
                    try {
                        json = JSON.parse(data);
                    } catch (error) {
                        console.error(`Error parsing JSON from file: ${filePath}`, error);
                        return;
                    }

                    const procedures = getProcedures(directory);
                    console.log(`Procedures to check: ${procedures}`);

                    // Verificar todo o JSON recursivamente usando a função para Omniscripts
                    if (checkIntegrationProceduresOmniscripts(json, procedures)) {
                        components.push({ type, name: `${directory}/${file}` });
                        console.log(`Found in json: ${directory}/${file}`);
                    }
                }
            });
        }
    });

    return components;
}

// Função para obter procedures para VlocityCards
function getVlocityCardProcedures(directory) {
    return [
        `val_CreateCustomerInteraction400`,
        `val_CreateCustomerInteraction`,
        `val_CreateCustomerInteractionAndTopic`,
        `val_CreateCustomerInteractionTopic`,
        `val_CreatesAutomaticToothpick`
    ];
}

// Função para obter procedures para Omniscripts
function getOmniscriptProcedures(directory) {
    return [
        `val_CreateCustomerInteraction400`,
        `val_CreateCustomerInteraction`,
        `val_CreateCustomerInteractionAndTopic`,
        `val_CreateCustomerInteractionTopic`,
        `val_CreatesAutomaticToothpick`
    ];
}

// Caminhos das pastas a serem verificadas
const vlocityCardsPath = 'C:\\Users\\hensilva\\Documents\\Rep\\Repositorio\\src-salesforceva-b2c\\autorabit_alldefault_vlocity_build\\VlocityCard';
const omniscriptsPath = 'C:\\Users\\hensilva\\Documents\\Rep\\Repositorio\\src-salesforceva-b2c\\autorabit_alldefault_vlocity_build\\Omniscript';

// Etapa 1: Processar os VlocityCards
const vlocityCardsComponents = findComponents(vlocityCardsPath, 'VlocityCard', getVlocityCardProcedures);

if (vlocityCardsComponents.length > 0) {
    console.log('VlocityCards encontrados: ', vlocityCardsComponents);

    // Etapa 2: Processar os Omniscripts, dependente dos resultados dos VlocityCards
    const omniscriptsComponents = findOmniscripts(omniscriptsPath, 'Omniscript', getOmniscriptProcedures);

    const allComponents = vlocityCardsComponents.concat(omniscriptsComponents);

    if (omniscriptsComponents.length > 0) {
        console.log('Omniscripts encontrados: ', omniscriptsComponents);
    } else {
        console.log('Nenhum Omniscript encontrado com as integration procedures especificadas.');
    }

    // Gerar o arquivo XLS
    const wb = xlsx.utils.book_new();
    const ws = xlsx.utils.json_to_sheet(allComponents);
    xlsx.utils.book_append_sheet(wb, ws, 'Components');
    xlsx.writeFile(wb, 'components.xlsx');

    console.log('Arquivo components.xlsx gerado com sucesso!');
} else {
    console.log('Nenhum VlocityCard encontrado com as integration procedures especificadas.');
}