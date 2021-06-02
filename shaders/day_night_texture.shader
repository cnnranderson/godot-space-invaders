shader_type canvas_item;

uniform vec2 Direction = vec2(-1.0, 0.0);
uniform float ScrollSpeed : hint_range(0.0, 1.0) = 0.02;
uniform float CycleSpeed : hint_range(0.0, 3.0) = 0.2;
uniform bool AutoCycle = true;
uniform vec4 Dusk_Gradient_Bottom : hint_color = vec4(0.87843, 0.64314, 0.43137, 1.0);
uniform vec4 Day_Gradient_Bottom : hint_color = vec4(0.21961, 0.43922, 0.74510, 1.0); //vec4(0.21, 0.84, 0.93, 1.0);
uniform vec4 Day_Gradient_Top : hint_color = vec4(0.08627, 0.02745, 0.07059, 1.0); //vec4(0.79, 0.96, 1.0, 1.0);

void fragment()
{
	// Calc the current gradient time
	float i_time = abs(sin(CycleSpeed * TIME));
	
	// Scroll the main texture horizontally
	COLOR = texture(TEXTURE, UV + Direction * ScrollSpeed * TIME);
	
	// Create the gradient for daytime sky colors
	vec4 col = vec4(0, 0, 0, 1);
	//col = Day_Gradient_Top + (UV.y * ((clamp(i_time, 0.0, 0.9) * Day_Gradient_Bottom) + ((1.0 - i_time) * Dusk_Gradient_Bottom)));
	col = Day_Gradient_Top + (UV.y * (Dusk_Gradient_Bottom + (i_time * (Day_Gradient_Bottom - Dusk_Gradient_Bottom))));
	
	// Cycle between day/night over time
	COLOR -= (i_time * (COLOR - col));
}

void vertex()
{	
	// Stretch vertical UV
	VERTEX.y += UV.y * 100.0;
	
	// Apply curve
	float height = 0.0015 * pow(VERTEX.x - 320.0, 2.0) - 100.0;
	VERTEX.y += height;
	
	// Slightly stretch the horizontal UV
	VERTEX.x += UV.x * 320.0 - 160.0;
}