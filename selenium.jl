using PyCall

# PyCall情報表示
println(PyCall.pyversion)
println(PyCall.pyprogramname)
println(PyCall.libpython)

# python/selenium パッケージ import
const webdriver = pyimport("selenium.webdriver")
const WebDriverWait = pyimport("selenium.webdriver.support.ui").WebDriverWait
const EC = pyimport("selenium.webdriver.support.expected_conditions")
# python/chromedriver_binary パッケージ import
pyimport("chromedriver_binary")

# ChromeWebDriverで Google WEBサイト取得
driver = webdriver.Chrome()
driver.get("https://www.google.co.jp")
# ロード待ち
WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located)
# 検索窓に "ChromeDriver" を入力し submit
search_box = driver.find_element_by_name("q")
search_box.send_keys("ChromeDriver")
search_box.submit()
# ロード待ち
WebDriverWait(driver, 10).until(EC.presence_of_all_elements_located)
# スクリーンショット保存
driver.save_screenshot("screenshot.png")
# ChromeWebDriver終了
driver.quit()
