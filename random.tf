#      _____                 _                 
#     |  __ \               | |                
#     | |__) |__ _ _ __   __| | ___  _ __ ___  
#     |  _  // _` | '_ \ / _` |/ _ \| '_ ` _ \ 
#     | | \ \ (_| | | | | (_| | (_) | | | | | |
#     |_|  \_\__,_|_| |_|\__,_|\___/|_| |_| |_|

resource "random_pet" "bucket-name" {
  length = 3
}

resource "random_pet" "shared-folder" {
  length = 3
}