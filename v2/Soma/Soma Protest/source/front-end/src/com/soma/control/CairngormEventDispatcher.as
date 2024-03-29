/*

Copyright (c) 2006. Adobe Systems Incorporated.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

  * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
  * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation
    and/or other materials provided with the distribution.
  * Neither the name of Adobe Systems Incorporated nor the names of its
    contributors may be used to endorse or promote products derived from this
    software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

@ignore
*/

package com.soma.control {
	import com.soma.errors.CairngormMessage;	
	import com.soma.errors.CairngormError;   
	
	import flash.events.IEventDispatcher;
   import flash.events.EventDispatcher;

   /**
    * The CairngormEventDispatcher class is a singleton class, used by the application
    * developer to broadcast events that correspond to user gestures and requests.
    *
    * <p>The singleton implementation of the CairngormEventDispatcher ensures that one
    * and only one class can be responsible for broadcasting events that the
    * FrontController is subscribed to listen and react to.</p>
    *
    * <p>
    * Since the CairngormEventDispatcher implements singleton access, use of the
    * singleton is simple to distribute throughout your application.  At
    * any point in your application, should you capture a user gesture
    * (such as in a click handler, or a dragComplete handler, etc) then
    * simply use a code idiom as follows:
    * </p>
    *
    * <pre>
    * //LoginEvent inherits from com.adobe.cairngorm.control.CairngormEvent
    * var eventObject : LoginEvent = new LoginEvent();
    * eventObject.username = username.text;
    * eventObject.password = username.password;
    * 
    * CairngormEventDispatcher.getInstance().dispatchEvent( eventObject );
    * </pre>
    *
    * @see com.soma.control.FrontController
    * @see com.soma.control.CairngormEvent
    */
   
   public class CairngormEventDispatcher
   {
   	
      private static var eventDispatcher : IEventDispatcher;
      private static var ced:CairngormEventDispatcher = new CairngormEventDispatcher();
      
      /**
       * Constructor.
       */
      public function CairngormEventDispatcher( target:IEventDispatcher = null ) 
      {
      	if (ced) throw new CairngormError(CairngormMessage.UTILS_SINGLETON_INSTANTIATION_ERROR, this);
			eventDispatcher = new EventDispatcher( target );
      }
      
      /**
       * Adds an event listener.
       */
      public static function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ) : void 
      {
         eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
      }
      
      /**
       * Removes an event listener.
       */
      public static function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ) : void 
      {
         eventDispatcher.removeEventListener( type, listener, useCapture );
      }

      /**
       * Dispatches a cairngorm event.
       */
      public static function dispatchEvent( event:CairngormEvent ) : Boolean 
      {
         return eventDispatcher.dispatchEvent( event );
      }
      
      /**
       * Returns whether an event listener exists.
       */
      public static function hasEventListener( type:String ) : Boolean 
      {
         return eventDispatcher.hasEventListener( type );
      }
      
      /**
       * Returns whether an event will trigger.
       */
      public static function willTrigger(type:String) : Boolean 
      {
         return eventDispatcher.willTrigger( type );
      }
   }
}