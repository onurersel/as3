/**
 * @author Onur Ersel
 * @date 21.11.2011 / 13:56
 */

package com.onurersel.mvc.controller
{
	import com.greensock.TweenLite;
	import com.onurersel.mvc.model.vo.SoundVO;

	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.Dictionary;


	/**
	 *
	 *
	 *
	 * REQUIRES TweenLite from greensocks
	 * http://www.greensock.com/tweenlite/
	 * 
	 *
	 *
	 */
	public class SoundController extends EventDispatcher
	{
		static private var instance : SoundController;

		public function SoundController()
		{
			if (instance)		throw new Error("SoundController is a singleton");
			else				init();
		}

		static public function getInstance() : SoundController
		{
			if (!instance)		instance = new SoundController();
			return instance;
		}

		private var soundDictionary		: Dictionary;
		private var soundVector			: Vector.<SoundVO>;
		private var _globalVolume		: Number;
		
		/**********      INIT      **********/
		
		private function init() : void
		{
			soundDictionary 	= new Dictionary();
			soundVector			= new Vector.<SoundVO>();
			_globalVolume 		= 1;
		}




		/**********      PLAYLIST      **********/

		public function addToPlaylist(sound : Sound,  title : String) : void
		{
			var soundVO : SoundVO = new SoundVO();
			soundVO.sound = sound;
			soundVO.title = title;
			soundVO.isPlaying = false;

			soundDictionary[title] = soundVO;
			soundVector.push(soundVO);
		}

		public function removeFromPlaylist(title : String) : void
		{
			delete(soundDictionary[title]);

			for (var i : int = 0; i < soundVector.length; i++)
			{
				var soundVO : SoundVO = soundVector[i];
				if(soundVO.title == title)
				{
					soundVector.splice(i, 1);
					break;
				}
			}
		}




		/**********      SOUND      **********/

		public function play(title : String, loopAmount : int = 0, volume : Number = 1, fadeInTime : Number = 0, startPosition : Number = 0) : SoundChannel
		{
			var soundVO : SoundVO = soundDictionary[title];

			if(soundVO.isPlaying)
			{
				stop(title,  0);
			}

			soundVO.isPlaying = true;
			soundVO.volume = volume;

			soundVO.channel = soundVO.sound.play(startPosition, loopAmount);

			TweenLite.killTweensOf(soundVO.channel);
			soundVO.channel.soundTransform.volume = 0;
			
			TweenLite.to(soundVO.channel, fadeInTime, {
						volume:soundVO.volume * globalVolume
					});

			return soundVO.channel;
		}

		public function stop(title : String, fadeDuration : Number = 1) : void
		{
			var soundVO : SoundVO = soundDictionary[title];

			TweenLite.killTweensOf(soundVO.channel);
			TweenLite.to(soundVO.channel, fadeDuration, {
						volume:0,
						onFadeComplete:function():void
						{
							soundVO.position = 0;
							soundVO.volume = 0;
							soundVO.isPlaying = false;
							soundVO.channel.stop();
						}
					});
		}

		public function stopAll(fadeDuration : Number = 1) : void
		{
			for (var i : int = 0; i < soundVector.length; i++)
			{
				var soundVO : SoundVO = soundVector[i];
				soundVO.volume = 0;
				soundVO.position = 0;
				soundVO.isPlaying = false;

				TweenLite.killTweensOf(soundVO.channel);
				TweenLite.to(soundVO.channel, fadeDuration, {
						volume:0,
						onFadeComplete:function():void
						{
							soundVO.position = 0;
							soundVO.volume = 0;
							soundVO.isPlaying = false;
							soundVO.channel.stop();
						}
					});
			}
		}
		
		public function pause(title : String) : void
		{
			var soundVo : SoundVO = soundDictionary[title];
			soundVo.position = soundVo.channel.position;
			soundVo.isPlaying = false;
			soundVo.channel.stop();
		}

		public function resume(title : String) : SoundChannel
		{
			var soundVO : SoundVO = soundDictionary[title];
			if(soundVO.isPlaying)		return soundVO.channel;

			soundVO.channel = soundVO.sound.play(soundVO.position,  0);
			return soundVO.channel;
		}


		public function checkIfSoundIsPlaying(title : String) : Boolean
		{
			var soundVO : SoundVO = soundDictionary[title].isPlaying;

			if (soundVO  &&  soundVO.isPlaying)
			{
				return soundVO.channel.position != soundVO.sound.length;
			}

			return false;
		}



		/**********      VOLUME      **********/

		public function setVolume(title : String, volume : Number = -1, fadeDuration : Number = 1) : void
		{
			var soundVO : SoundVO = soundDictionary[title];

			if(volume >= 0)
			{
				soundVO.volume = volume;
				
				TweenLite.killTweensOf(soundVO.channel);
				TweenLite.to(soundVO.channel, fadeDuration, {
							volume:soundVO.volume * globalVolume
						});
			}

		}

		public function setGlobalVolume(volume : Number, fadeDuration : Number = 1) : void
		{
			globalVolume = volume;

			for (var i : int = 0; i < soundVector.length; i++)
			{
				var soundVO : SoundVO = soundVector[i];
				TweenLite.killTweensOf(soundVO.channel);
				TweenLite.to(soundVO.channel, fadeDuration, {
							volume:soundVO.volume * globalVolume
						});
			}
		}


		/**********      GETTER / SETTER      **********/

		public function get globalVolume() : Number
		{
			return _globalVolume;
		}

		public function set globalVolume(value : Number) : void
		{
			_globalVolume = value;
		}
	}
}