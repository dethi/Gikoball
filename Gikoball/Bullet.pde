class Bullet
{
    // Postions
    float initial_x;
    float x;
    float y;
    float left;
    float right;
    float top;
    float bottom;
    float bullet_width;
    float bullet_height;
    String bullet_image;

    float velocity_x;
    boolean has_reached;
    boolean to_remove;

    Bullet(float x, float y, float bullet_width, float bullet_height,
            String bullet_image, float velocity)
    {
        initial_x = x;

        // Coordonnates
        this.x = x;
        this.y = y;
        this.bullet_height = bullet_height;
        this.bullet_width = bullet_width;
        // Sprite
        this.bullet_image = bullet_image;

        // Positions for collisions
        left = x;
        right = x + bullet_width;
        top = y;
        bottom = y + bullet_height;

        velocity_x = velocity;
        has_reached = false;
        to_remove = false;
    }

    void draw(int shift, ArrayList<Platform> platform_list)
    {
        update(platform_list);
        image(loadImage(this.bullet_image), this.x - shift, this.y, this.bullet_width, this.bullet_height);
    }

    void update(ArrayList<Platform> platform_list)
    {
        update_has_reached();
        if (has_reached)
            to_remove = true;
        this.x += velocity_x;
        for (int i = 0; i < platform_list.size(); ++i)
        {
            if (is_collinding_with_platform(platform_list.get(i).x,
                        platform_list.get(i).y, platform_list.get(i).platform_width, platform_list.get(i).platform_height))
                has_reached = true;
        }
    }

    void update_has_reached()
    {
        if (dist(initial_x, y, x, y) > 700)
            has_reached = true;
    }

    boolean is_collinding_with_platform(
            float rectangleX,
            float rectangleY,
            float platform_width,
            float platform_height)
    {
        float distance_x = abs((this.x+this.bullet_width/2) - rectangleX - platform_width / 2);
        float distance_y = abs((this.y+this.bullet_height/2) - rectangleY - platform_height / 2);

        if (distance_x > (platform_width / 2 + this.bullet_width/2))
            return false;
        if (distance_y > (platform_height/2 + this.bullet_height/2))
            return false;
        if (distance_x <= (platform_width/2))
            return true;
        if (distance_y <= (platform_height/2))
            return true;

        float corner_distance_sq = pow(distance_x - platform_width/2, 2) +
            pow(distance_y - platform_height/2, 2);

        return (corner_distance_sq <= pow(this.bullet_width/2, 2));
    }

}

