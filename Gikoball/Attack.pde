class Attack 
{
    float x, y;
    float speedX, atk_speed;
    float left, right;
    float top, bottom;
    float atk_width, atk_height;
    float damage=0;
    String atk_img; //named like "atk_whatever.png"
    boolean thrown=false;
    
    //constructor
    Attack(float x, float y, float atk_height, float atk_width,
    String atk_img) {
        this.x = x;
        this.y = y;
        this.atk_height = atk_height;
        this.atk_width = atk_width;
        this.atk_img = atk_img;
    
        this.left = x;
        this.right = x + atk_width;
        this.top = y;
        this.bottom = y + atk_height;
        
        if (atk_img.equals("atk_ki.png")) {
            this.damage=1;
            this.atk_speed=10;
  
        } else if (atk_img.equals("atk_kame.png")) {
            this.damage=4;
            this.atk_speed=5;
        } 
    }
    
    void setX (float x) {
        this.x=x;
    }
    void setY (float y) {
        this.y=y;
    }
    
    void draw(Platform[] platform_list, int shift) 
    {
        this.x+= shift;
        update(platform_list);
        this.x-= shift;
        image( loadImage(this.atk_img), this.x, this.y, this.atk_width,  this.atk_height);
        if (this.x>SCREEN_WIDTH)
            this.thrown=false;
    }
    
    void update(Platform[] platform_list)
    {
        update_position(); 
        collides(platform_list);
    }
    
    void update_position()
    {
        right = x + this.atk_width/2;
        left = x - this.atk_width/2;
        top = y - this.atk_height/2;
        bottom = y + this.atk_height/2;
        if (this.thrown) 
          this.speedX=this.atk_speed;        
        
        this.x+=this.speedX;
    }
    
    void collides(Platform[] platform_list)
    {
        for (int i = 0; i < platform_list.length; ++i)
        {
            if (is_atk_collinding_with_platform(platform_list[i].x, platform_list[i].y,
            platform_list[i].platform_width, platform_list[i].platform_height))
            {
                if (platform_list[i].platform_image.equals("green_platform.png") ||
                platform_list[i].platform_image.equals("red_platform.png")/*|| etc*/) {
                //dissapear
                  this.thrown=false;
                  
                } else if (platform_list[i].platform_image.equals("enemy_01.png") ||
                platform_list[i].platform_image.equals("enemy_02.png")/*|| etc*/) {
                  //deals this.damage
                  /*Insert enemies begging for merci here*/
                  
                }              
            }
        }
    }
    
    boolean is_atk_collinding_with_platform(
            float rectangleX, 
            float rectangleY, 
            float platform_width, 
            float platform_height)
    {
        float distance_x = abs((this.x+this.atk_width/2) - rectangleX - platform_width / 2);
        float distance_y = abs((this.y+this.atk_height/2) - rectangleY - platform_height / 2);

        if (distance_x > (platform_width / 2 + this.atk_width/2))
            return false;
        if (distance_y > (platform_height/2 + this.atk_height/2)) 
            return false;
        if (distance_x <= (platform_width/2))
            return true;
        if (distance_y <= (platform_height/2))
            return true;
            
        float corner_distance_sq = pow(distance_x - platform_width/2, 2) +
            pow(distance_y - platform_height/2, 2);

        return (corner_distance_sq <= pow(this.atk_width/2, 2));
    }

}
