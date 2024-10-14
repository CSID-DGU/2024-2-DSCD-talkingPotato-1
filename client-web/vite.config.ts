import {defineConfig} from 'vite'
import react from '@vitejs/plugin-react'
import path from "path"
import svgr from 'vite-plugin-svgr'

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [react(), svgr()],
    optimizeDeps: {
        exclude: ['@uiw/react-md-editor']
    },
    resolve: {
        alias: {
            "@app": path.resolve(__dirname, 'src/app'),
            "@features": path.resolve(__dirname, 'src/features'),
            "@pages": path.resolve(__dirname, 'src/pages'),
            "@shared": path.resolve(__dirname, 'src/shared'),
        }
    }
})
