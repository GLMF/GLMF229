const puppeteer = require('puppeteer')
const screenshot = 'capture.png';

function getParams() {
  const args = process.argv.slice(2);
  const argsNamed = require('minimist')(args);

  if (args.length < 1 || args.length > 2 || argsNamed['url'] == undefined) {
    console.error('Syntax: node note.js <url>')
    return process.exit(1)
  }
  return {
    'url': argsNamed['url'], 
    'init': argsNamed['init']
  }
}

function readEDT() {
  try{
    let edt = require('fs').readFileSync(
      './edt.json',
      'utf8'
    )
    return JSON.parse(edt)
  } catch {
    return undefined
  }
}

function saveEDT(edt) {
  require('fs').writeFile(
    './edt.json',
    JSON.stringify(edt),
    function (err) {
      if (err) {
        console.error('Error detected while writing edt.json');
      }
    }
  )
}

function alertModification(telNumber) {
  const shell = require('shelljs');
  shell.exec('/usr/bin/gammu sendsms TEXT ' + telNumber + ' -text "Attention, modification d\'emploi du temps !"')
}

function isDifferentEDT(newEDT, oldEDT) {
  if (newEDT != oldEDT) {
    saveEDT(newEDT)
    return true
  }
  return false
}

function webScraping(urlName, init, alertAction) {
  (async url => {
    const browser = await puppeteer.launch({headless: false})
    const page = await browser.newPage()
    await page.goto(url)

    // Connexion
    await page.waitForSelector('#id_53', { visible: true })
    await page.type('#id_53', process.env.MY_USER)
    await page.waitForSelector('#id_54', { visible: true })
    await page.type('#id_54', process.env.MY_PWD)
    await page.waitForSelector('#id_43', { visible: true })
    await page.click('#id_43')
    await page.waitForNavigation()

    // Accès à l'emploi du temps (on prend title car id mouvant)
    await page.waitForSelector('[title="Tout voir"]', { visible: true })
    await page.click('[title="Tout voir"]')

    // Recherche des cours annulés
    await page.waitForSelector('.EmploiDuTemps_Element', { visible: true })
    let elements = await page.$$('.EmploiDuTemps_Element')

    let evts = []
    for (let n=0; n < elements.length; n++) {
      try {
        let elt = await page.evaluateHandle(e => e.firstElementChild.firstElementChild.firstElementChild.firstElementChild.firstElementChild.firstElementChild.firstElementChild.innerHTML, elements[n])
        evts[n] = elt._remoteObject['value']
      } catch {
        evts[n] = null
      }
    }
    evts = JSON.stringify(evts)

    // Remise à zéro de l'emploi du temps
    if (init != undefined) {
      console.log('RAZ')
      saveEDT(evts)
    }

    // Lecture de l'ancien emploi du temps et comparaison
    edt = readEDT()
    if (isDifferentEDT(evts, edt)) {
      alertAction()
    }

    browser.close()
  })(urlName)
}


// Main
const params = getParams()
webScraping(params['url'], params['init'], () => alertModification('0612345678'))
