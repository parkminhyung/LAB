ifelse(!require(pacman),
       install.packages('pacman'),
       library(pacman))
pacman::p_load('rvest','stringr','vroom')

files = 'http://sf.cufe.edu.cn/kydt/kyjg/zgzcglyjzx/xzzq.htm' %>% 
  read_html() %>% 
  html_nodes('a') %>% 
  .[grep(x=.,'五因子数据')] %>% 
  html_attr('href') %>% .[1] %>% 
  str_remove('../../..') %>% 
  paste0('http://sf.cufe.edu.cn',.) %>% 
  read_html() %>% 
  html_nodes('li') %>% 
  .[grep(x=.,'附件')] %>% 
  html_nodes('a') %>% 
  html_attr('href') %>% 
  paste0('http://sf.cufe.edu.cn',.)

file_list = list('Fama_French_China_daily.zip',
              'Fama_French_China_weekly.zip',
              'Fama_French_China_monthly.zip',
              'Fama_French_China_yearly.zip') 

#download models 
sapply(1:length(file_list), function(x){
  download.file(files[x],
                file.path(getwd(),file_list[[x]])) 
  unzip(file.path(getwd(),file_list[[1]]),
        exdir = getwd())
})
