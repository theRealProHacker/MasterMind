images = {}

images["background"]=love.graphics.newImage("images/normal_background.jpg")
images["green-arrow"]=love.graphics.newImage("images/double-arrow.png")
types= {"red","blue","green","yellow"}

for k,v in pairs(types) do
    images[v]=love.graphics.newImage("images/".. v .. "-default.png")
end