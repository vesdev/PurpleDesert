if (keyboard_check_pressed(vk_space))
{
    if (element.get_typewriter_paused())
    {
        //If we're paused, unpause!
        element.typewriter_unpause(false);
    }
    else if (element.get_typewriter_state() >= 1)
    {
        skip = false;
        
        if (element.get_page() >= element.get_pages() - 1)
        {
            //Wrap back round to the first page
            element.page(0);
        }
        else
        {
            //Otherwise move to the next page
            element.page(element.get_page() + 1);
        }
    }
    else
    {
        skip = true;
    }
}