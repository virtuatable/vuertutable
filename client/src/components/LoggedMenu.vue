<template>
  <v-app-bar dark dense app>
    <v-btn text to="/" class="hidden-xs-only">
      <span class="mr-2">{{ $t('buttons.home') }}</span>
    </v-btn>
    <v-btn to="/" icon class="hidden-sm-and-up">
      <v-icon>mdi-home</v-icon>
    </v-btn>

    <v-spacer></v-spacer>

    <v-btn text @click.prevent.stop="signout()" class="hidden-xs-only">
      <span class="mr-2">{{ $t('buttons.signout') }}</span>
    </v-btn>

    <v-btn @click.prevent.stop="signout()" icon class="hidden-sm-and-up">
      <v-icon>mdi-login</v-icon>
    </v-btn>
  </v-app-bar>
</template>

<script>
  import { mapState } from 'vuex'
  import api from '@/lib/api'

  export default {
    data: () => ({
      displayMenu: false
    }),
    computed: {
      ...mapState(['token'])
    },
    methods: {
      signout() {
        const params = {
          session_id: this.token
        }
        api('delete', `/sessions/${this.token}`, params).then(r => {
          this.$store.commit('logout')
          this.$router.push({name: 'Home'})
            .catch(() => {})
          })
      }
    }
  }
</script>

<i18n>
{
  "en_GB": {
    "buttons": {
      "home": "Home",
      "signout": "Log out"
    }
  },
  "fr_FR": {
    "buttons": {
      "home": "Accueil",
      "signout": "Déconnexion"
    }
  }
}
</i18n>