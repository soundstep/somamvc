/**
 * Equations
 * Main equations for the Tweener class, ported over for use with GOASAP and Tween3D
 *
 * @author		Zeh Fernando, Nate Chatellier
 * @author		John Grden
 * @author		Romuald Quantin
 * @version		1.0.3
 */

/*
Disclaimer for Robert Penner's Easing Equations license:

TERMS OF USE - EASING EQUATIONS

Open source under the BSD License.

Copyright © 2001 Robert Penner
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of the author nor the names of contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

package com.soundstep.utils {
		
	public class Easing {	
		/**
		 * There's no constructor.
		 * @private
		 */
		public function Easing() {
			trace ("Equations is a static class and should not be instantiated.");
		}
	
	// ==================================================================================================================================
	// TWEENING EQUATIONS functions -----------------------------------------------------------------------------------------------------
	// (the original equations are Robert Penner's work as mentioned on the disclaimer)

		/**
		 * Easing equation function for a simple linear tweening, with no easing.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function None (t:Number, b:Number, c:Number, d:Number):Number {
			return c*t/d + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing in: accelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuadIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing out: decelerating to zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuadOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c *(t/=d)*(t-2) + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing in/out: acceleration until halfway, then deceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuadInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1) return c/2*t*t + b;
			return -c/2 * ((--t)*(t-2) - 1) + b;
		}
	
		/**
		 * Easing equation function for a quadratic (t^2) easing out/in: deceleration until halfway, then acceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuadOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return QuadOut (t*2, b, c/2, d);
			return QuadIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for a cubic (t^3) easing in: accelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CubicIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t + b;
		}
	
		/**
		 * Easing equation function for a cubic (t^3) easing out: decelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CubicOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*((t=t/d-1)*t*t + 1) + b;
		}
	
		/**
		 * Easing equation function for a cubic (t^3) easing in/out: acceleration until halfway, then deceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CubicInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1) return c/2*t*t*t + b;
			return c/2*((t-=2)*t*t + 2) + b;
		}
	
		/**
		 * Easing equation function for a cubic (t^3) easing out/in: deceleration until halfway, then acceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function easeOutInCubic (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return CubicOut (t*2, b, c/2, d);
			return CubicIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for a quartic (t^4) easing in: accelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuartIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t*t + b;
		}
	
		/**
		 * Easing equation function for a quartic (t^4) easing out: decelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuartOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c * ((t=t/d-1)*t*t*t - 1) + b;
		}
	
		/**
		 * Easing equation function for a quartic (t^4) easing in/out: acceleration until halfway, then deceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuartInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1) return c/2*t*t*t*t + b;
			return -c/2 * ((t-=2)*t*t*t - 2) + b;
		}
	
		/**
		 * Easing equation function for a quartic (t^4) easing out/in: deceleration until halfway, then acceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuartOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return QuartOut (t*2, b, c/2, d);
			return QuartIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for a quintic (t^5) easing in: accelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuintIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c*(t/=d)*t*t*t*t + b;
		}
	
		/**
		 * Easing equation function for a quintic (t^5) easing out: decelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuintOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c*((t=t/d-1)*t*t*t*t + 1) + b;
		}
	
		/**
		 * Easing equation function for a quintic (t^5) easing in/out: acceleration until halfway, then deceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuintInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1) return c/2*t*t*t*t*t + b;
			return c/2*((t-=2)*t*t*t*t + 2) + b;
		}
	
		/**
		 * Easing equation function for a quintic (t^5) easing out/in: deceleration until halfway, then acceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function QuintOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return QuintOut (t*2, b, c/2, d);
			return QuintIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for a sinusoidal (sin(t)) easing in: accelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function SineIn (t:Number, b:Number, c:Number, d:Number):Number {
			return -c * Math.cos(t/d * (Math.PI/2)) + c + b;
		}
	
		/**
		 * Easing equation function for a sinusoidal (sin(t)) easing out: decelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function SineOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sin(t/d * (Math.PI/2)) + b;
		}
	
		/**
		 * Easing equation function for a sinusoidal (sin(t)) easing in/out: acceleration until halfway, then deceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function SineInOut (t:Number, b:Number, c:Number, d:Number):Number {
			return -c/2 * (Math.cos(Math.PI*t/d) - 1) + b;
		}
	
		/**
		 * Easing equation function for a sinusoidal (sin(t)) easing out/in: deceleration until halfway, then acceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function SineOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return SineOut (t*2, b, c/2, d);
			return SineIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for an exponential (2^t) easing in: accelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function ExpoIn (t:Number, b:Number, c:Number, d:Number):Number {
			return (t==0) ? b : c * Math.pow(2, 10 * (t/d - 1)) + b - c * 0.001;
		}
	
		/**
		 * Easing equation function for an exponential (2^t) easing out: decelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function ExpoOut (t:Number, b:Number, c:Number, d:Number):Number {
			return (t==d) ? b+c : c * 1.001 * (-Math.pow(2, -10 * t/d) + 1) + b;
		}
	
		/**
		 * Easing equation function for an exponential (2^t) easing in/out: acceleration until halfway, then deceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function ExpoInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if (t==0) return b;
			if (t==d) return b+c;
			if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b - c * 0.0005;
			return c/2 * 1.0005 * (-Math.pow(2, -10 * --t) + 2) + b;
		}
	
		/**
		 * Easing equation function for an exponential (2^t) easing out/in: deceleration until halfway, then acceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function ExpoOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return ExpoOut (t*2, b, c/2, d);
			return ExpoIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for a circular (sqrt(1-t^2)) easing in: accelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CircIn (t:Number, b:Number, c:Number, d:Number):Number {
			return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
		}
	
		/**
		 * Easing equation function for a circular (sqrt(1-t^2)) easing out: decelerating from zero velocity.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CircOut (t:Number, b:Number, c:Number, d:Number):Number {
			return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
		}
	
		/**
		 * Easing equation function for a circular (sqrt(1-t^2)) easing in/out: acceleration until halfway, then deceleration.
 		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CircInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
			return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
		}
	
		/**
		 * Easing equation function for a circular (sqrt(1-t^2)) easing out/in: deceleration until halfway, then acceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function CircOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return CircOut (t*2, b, c/2, d);
			return CircIn((t*2)-d, b+c/2, c/2, d);
		}
	
		/**
		 * Easing equation function for an elastic (exponentially decaying sine wave) easing in: accelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param a		Amplitude.
		 * @param p		Period.
		 * @return		The correct value.
		 */
		public static function ElasticIn (t:Number, b:Number, c:Number, d:Number, a:Number = Number.NaN, p:Number = Number.NaN):Number {
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			var s:Number;
			if (!a || a < Math.abs(c)) { a=c; s=p/4; }
			else s = p/(2*Math.PI) * Math.asin (c/a);
			return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
		}
	
		/**
		 * Easing equation function for an elastic (exponentially decaying sine wave) easing out: decelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param a		Amplitude.
		 * @param p		Period.
		 * @return		The correct value.
		 */
		public static function ElasticOut (t:Number, b:Number, c:Number, d:Number, a:Number = Number.NaN, p:Number = Number.NaN):Number {
			if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
			var s:Number;
			if (!a || a < Math.abs(c)) { a=c; s=p/4; }
			else s = p/(2*Math.PI) * Math.asin (c/a);
			return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b);
		}
	
		/**
		 * Easing equation function for an elastic (exponentially decaying sine wave) easing in/out: acceleration until halfway, then deceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param a		Amplitude.
		 * @param p		Period.
		 * @return		The correct value.
		 */
		public static function ElasticInOut (t:Number, b:Number, c:Number, d:Number, a:Number = Number.NaN, p:Number = Number.NaN):Number {
			if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
			var s:Number;
			if (!a || a < Math.abs(c)) { a=c; s=p/4; }
			else s = p/(2*Math.PI) * Math.asin (c/a);
			if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b;
			return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b;
		}
	
		/**
		 * Easing equation function for an elastic (exponentially decaying sine wave) easing out/in: deceleration until halfway, then acceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param a		Amplitude.
		 * @param p		Period.
		 * @return		The correct value.
		 */
		public static function ElasticOutIn (t:Number, b:Number, c:Number, d:Number, a:Number = Number.NaN, p:Number = Number.NaN):Number {
			if (t < d/2) return ElasticOut (t*2, b, c/2, d, a, p);
			return ElasticIn((t*2)-d, b+c/2, c/2, d, a, p);
		}
	
		/**
		 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in: accelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
		 * @return		The correct value.
		 */
		public static function BackIn (t:Number, b:Number, c:Number, d:Number, s:Number = Number.NaN):Number {
			if (!s) s = 1.70158;
			return c*(t/=d)*t*((s+1)*t - s) + b;
		}
	
		/**
		 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out: decelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
		 * @return		The correct value.
		 */
		public static function BackOut (t:Number, b:Number, c:Number, d:Number, s:Number = Number.NaN):Number {
			if (!s) s = 1.70158;
			return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
		}
	
		/**
		 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing in/out: acceleration until halfway, then deceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
		 * @return		The correct value.
		 */
		public static function BackInOut (t:Number, b:Number, c:Number, d:Number, s:Number = Number.NaN):Number {
			if (!s) s = 1.70158;
			if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
			return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;
		}
	
		/**
		 * Easing equation function for a back (overshooting cubic easing: (s+1)*t^3 - s*t^2) easing out/in: deceleration until halfway, then acceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @param s		Overshoot ammount: higher s means greater overshoot (0 produces cubic easing with no overshoot, and the default value of 1.70158 produces an overshoot of 10 percent).
		 * @return		The correct value.
		 */
		public static function BackOutIn (t:Number, b:Number, c:Number, d:Number, s:Number = Number.NaN):Number {
			if (t < d/2) return BackOut (t*2, b, c/2, d, s);
			return BackIn((t*2)-d, b+c/2, c/2, d, s);
		}
	
		/**
		 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in: accelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function BounceIn (t:Number, b:Number, c:Number, d:Number):Number {
			return c - BounceOut (d-t, 0, c, d) + b;
		}
	
		/**
		 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out: decelerating from zero velocity.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function BounceOut (t:Number, b:Number, c:Number, d:Number):Number {
			if ((t/=d) < (1/2.75)) {
				return c*(7.5625*t*t) + b;
			} else if (t < (2/2.75)) {
				return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
			} else if (t < (2.5/2.75)) {
				return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
			} else {
				return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
			}
		}
	
		/**
		 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing in/out: acceleration until halfway, then deceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function BounceInOut (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return BounceIn (t*2, 0, c, d) * .5 + b;
			else return BounceOut (t*2-d, 0, c, d) * .5 + c*.5 + b;
		}
	
		/**
		 * Easing equation function for a bounce (exponentially decaying parabolic bounce) easing out/in: deceleration until halfway, then acceleration.
		 *
		 * @param t		Current time (in frames or seconds).
		 * @param b		Starting value.
		 * @param c		Change needed in value.
		 * @param d		Expected easing duration (in frames or seconds).
		 * @return		The correct value.
		 */
		public static function BounceOutIn (t:Number, b:Number, c:Number, d:Number):Number {
			if (t < d/2) return BounceOut (t*2, b, c/2, d);
			return BounceIn((t*2)-d, b+c/2, c/2, d);
		}
	}
}
